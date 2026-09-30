extends Area2D

var entered = false

var Telepos = Vector2(1850, -500)
signal enterRoome2frome3
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
		get_tree().change_scene_to_file("res://Ember/Ember Room #2/ember_room_#2.tscn")
		Transition.fadeout()
		enterRoome2frome3.emit()
