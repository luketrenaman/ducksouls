extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal gameover
var waiting_x = 0
var waiting_y = 0
var WAIT_TIME = 0.1
var playable = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input(delta):
	if waiting_x > 0 and waiting_y > 0:
		return
	var MOVE_VECTOR = Vector2(0,0)
	if waiting_x <= 0:
		if Input.is_action_pressed("left") or Input.is_action_just_pressed("left"):
			MOVE_VECTOR += Vector2(-1,0)
			self.scale.x = -1
		if Input.is_action_pressed("right") or Input.is_action_just_pressed("right"):
			MOVE_VECTOR += Vector2(1,0)
			self.scale.x = 1
		if MOVE_VECTOR.x != 0:
			waiting_x = WAIT_TIME
	if waiting_y <= 0:
		if Input.is_action_pressed("up") or Input.is_action_just_pressed("up"):
			MOVE_VECTOR += Vector2(0,-1)
		if Input.is_action_pressed("down") or Input.is_action_just_pressed("down"):
			MOVE_VECTOR += Vector2(0,1)
		if MOVE_VECTOR.y != 0:
			waiting_y = WAIT_TIME
	if MOVE_VECTOR == Vector2(0,0):
		return
	if (self.position + MOVE_VECTOR).x < 0:
		return
	if (self.position + MOVE_VECTOR).y < 0:
		return
	if (self.position + MOVE_VECTOR).x > 190:
		return
	if (self.position + MOVE_VECTOR).y > 130:
		return
	self.position += MOVE_VECTOR * 10
func reset_game():
	emit_signal("gameover")
	play("death")
	playable = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playable:
		waiting_x -= delta
		waiting_y -= delta
		get_input(delta)
		pass


func _on_Area2D_area_entered(area):
	if playable:
		reset_game()
	pass # Replace with function body.
