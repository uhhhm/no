extends Button


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _pressed() -> void:
	print("started")
	Transition.change_scene()
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://Room1/room#1_spawn.tscn")
	Transition.fadeout()


func _on_button_down() -> void:
	print("down")
