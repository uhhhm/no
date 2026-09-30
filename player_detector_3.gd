extends Area2D

var entered = false

var Telepos = Vector2(1117, 1581)
signal enterRoom1 
# Called when the node enters the scene tree for the first time.

func _on_body_entered(body) -> void:
	var player := body as PhysicsBody2D
	if not player:
		return
	entered = true
	
func _on_body_exited(body) -> void:
	var player := body as PhysicsBody2D
	if not player:
		return
	entered = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if entered == true:
		Transition.change_scene()
		await get_tree().create_timer(0.6).timeout
		get_tree().change_scene_to_file("res://Room1/room#1_spawn.tscn")
		Transition.fadeout()
		enterRoom1.emit()
