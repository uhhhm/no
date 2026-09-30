extends Area2D

var entered = false


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
	$AnimationPlayer.play("fadeout")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if entered == true:
		$AnimationPlayer.play("fadein")
		if Input.is_action_just_pressed("Interact") and Globalvariables.pennonUnlock == true:
			print("FD-CE")
			Transition.change_scene()
			await get_tree().create_timer(0.8).timeout
			Transition.FDCET()
			await get_tree().create_timer(12.1).timeout
			Transition.change_scene()
			await get_tree().create_timer(0.6).timeout
			get_tree().change_scene_to_file("res://Ember/Ember Room #1/ember_room_#1.tscn")
			Transition.fadeout()
			
			
		
