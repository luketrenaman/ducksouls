extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0
var phase = 0
var phase_durations = [10,20,20,20,20]
var game_over = false
var rng = RandomNumberGenerator.new()
#phase constants
var PHASE_A = false
var dangers = []

onready var DUCK = get_node("EntityGrid2/Duck")
var DUCK_SPEED = 1
var game_end = false

onready var PLAYER = get_node("EntityGrid/Player")


onready var FLAME = preload("res://Flame.tscn")
onready var DANGER_TILE = preload("res://DangerousTile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,2):
		dangers.append([])
		for j in range(0,2):
			var dangerous_tile = DANGER_TILE.instance()
			dangers[i].append(dangerous_tile)
			$Flames.add_child(dangerous_tile)
	rng.randomize()
	pass # Replace with function body.
func _process(delta):
	if not game_end:
		for i in range(0,2):
			for j in range(0,2):
				var duck_pos = $EntityGrid2/Duck.get_position() - Vector2(-5,-15)
				dangers[i][j].position = duck_pos + i * Vector2(10,0) + j * Vector2(0,10)
				dangers[i][j].position.x -= fmod(dangers[i][j].position.x,10) - 5
				dangers[i][j].position.y -= fmod(dangers[i][j].position.y,10) - 5
			
func flame_column(x):
	for i in range(0,14):
		make_flame(x,i)
func flame_column_rand():
	flame_column(rng.randi_range(0,19))


func flame_row(y):
	for i in range(0,20):
		make_flame(i,y)
func flame_row_rand():
	flame_row(rng.randi_range(0,14))


func rand_flame():
	var x = rng.randi_range(0,19)
	var y = rng.randi_range(0,13)
	make_flame(x,y)
func make_flame(loc_x,loc_y):
	var flame = FLAME.instance()
	flame.position.x = (loc_x*10 + 5)
	flame.position.y = (loc_y*10 + 15)
	$Flames.add_child(flame)
#-- DUCK MOVEMENT METHODS --
func patrol(v1,v2,towards):
	DUCK.play("walk")
	if towards:
		#go to v1
		var vec = (DUCK.position - v1).normalized()
		if vec.x < 0:
			DUCK.scale.x = -1
		else:
			DUCK.scale.x = 1
		DUCK.position -= vec * DUCK_SPEED
		if (DUCK.position - v1).length() < 16:
			PHASE_A = not towards
	else:
		var vec = (DUCK.position - v2).normalized()
		if vec.x < 0:
			DUCK.scale.x = -1
		else:
			DUCK.scale.x = 1
		DUCK.position -= vec * DUCK_SPEED
		if (DUCK.position - v2).length() < 16:
			PHASE_A = not towards
		#go to v2
func goto(pos):
	var vec = (DUCK.position - pos).normalized()
	if vec.x < 0:
		DUCK.scale.x = -1
	else:
		DUCK.scale.x = 1
	DUCK.position -= vec * DUCK_SPEED
func snap_to():
	var npos = DUCK.position
	npos.x -= fmod(npos.x,10)
	npos.y -= fmod(npos.y,10)
	var a = DUCK.position
	goto(npos)
	if abs(DUCK.position.x - npos.x) < DUCK_SPEED:
		DUCK.position.x = npos.x
	if abs(DUCK.position.y - npos.y) < DUCK_SPEED:
		DUCK.position.y = npos.y
	var b = DUCK.position
	if (a - b).length() < 0.01:
		DUCK.play("default")
	else:
		DUCK.play("walk")
func follow_player():
	goto(PLAYER.position)
func get_player_location():
	return $EntityGrid/Player.get_position()+Vector2(0,10)
func get_duck_location():
	return $EntityGrid2/Duck.get_position()+Vector2(0,10)
func phase_one():
	if time < 20:
		return
	if time % 10 == 0:
		for i in range(0,5):
			rand_flame()
	patrol(Vector2(50,70),Vector2(150,70),PHASE_A)
func phase_two():
	if time < 20:
		snap_to()
		return
	if time % 30 == 0:
		flame_column_rand()
	follow_player()
func phase_three():
	if time < 20:
		snap_to()
		return
	if time % 30 == 0:
		flame_column((time/30) % 20)
		flame_column((time/30 + 4) % 20)
		flame_column((time/30 + 8) % 20)
		flame_column((time/30 + 12) % 20)
		flame_column((time/30 + 16) % 20)
	follow_player()
func phase_four():
	if time < 20:
		snap_to()
		return
	if time % 30 == 0:
		for i in range(0,20):
			rand_flame()
	if time % 30 == 15:
		flame_row(get_player_location().y/10-1)
		flame_column(get_player_location().x/10)
func phase_five():
	if time < 20:
		snap_to()
		return
	DUCK_SPEED = 4
	follow_player()
	if time % 20 == 0:
		flame_column(int(get_duck_location().x/10) - 5)
		flame_column(int(get_duck_location().x/10) + 5)
	
func phase_final():
	snap_to()
	if time < 20:
		return
	if time % 50 == 0:
		var p = get_player_location()/10
		flame_column(p.x-1)
		flame_column(p.x)
		flame_column(p.x+1)
		flame_row(p.y-1)
		flame_row(p.y)
		flame_row(p.y+1)
	
func _on_Timer_timeout():
	if game_end:
		return
	if phase_durations[phase] * 10 <= time:
		phase += 1
		time = 0
	if phase > len(phase_durations) - 1:
		for arr in dangers:
			for obj in arr:
				obj.queue_free()
		game_end = true
		$Victory/AnimationPlayer.play("fade_in")
		$Victory/Menu.disabled = false
		$Victory/Menu.mouse_default_cursor_shape = Input.CURSOR_POINTING_HAND
		DUCK.play("death")
		$EntityGrid/Player.play("idle")
		$Timer.stop()
		return
	match phase:
		0:
			phase_one()
		1:
			phase_two()
		2:
			phase_three()
		3:
			phase_four()
		4:
			phase_five()
		_:
			phase_final()
	time += 1
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	pass # Replace with function body.


func _on_Player_gameover():
	$Timer.queue_free()
	$GameOver/AnimationPlayer.play("fade_in")
	$GameOver/GiveUp.disabled = false
	$GameOver/GiveUp.mouse_default_cursor_shape = Input.CURSOR_POINTING_HAND
	$GameOver/TryAgain.disabled = false
	$GameOver/TryAgain.mouse_default_cursor_shape = Input.CURSOR_POINTING_HAND
	pass # Replace with function body.

func _on_GiveUp_pressed():
	get_tree().change_scene("res://titlescreen.tscn")
	pass # Replace with function body.


func _on_TryAgain_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Menu_pressed():
	get_tree().change_scene("res://titlescreen.tscn")
	pass # Replace with function body.


func _on_Duck_animation_finished():
	if DUCK.animation == "death":
		DUCK.queue_free()
	pass # Replace with function body.


func _on_Player_animation_finished():
	if $EntityGrid/Player.animation == "death":
		$EntityGrid/Player.queue_free()
	pass # Replace with function body.
