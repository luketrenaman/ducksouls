extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum STATES{NORMAL,HARDCORE}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func sel(state):
	if state == STATES.NORMAL:
		$Normal.visible = false
		$NormalSelected.visible = true
		$Hardcore.visible = true
		$HardcoreSelected.visible = false
		Global.game_mode = "normal"
	if state == STATES.HARDCORE:
		$Normal.visible = true
		$NormalSelected.visible = false
		$Hardcore.visible = false
		$HardcoreSelected.visible = true
		Global.game_mode = "hardcore"
func _on_Play_pressed():
	get_tree().change_scene("res://game.tscn")
	pass # Replace with function body.


func _on_Normal_pressed():
	sel(STATES.NORMAL)
	pass # Replace with function body.
func _on_Hardcore_pressed():
	sel(STATES.HARDCORE)
	pass # Replace with function body.
