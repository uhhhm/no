extends CanvasLayer


# Called when the node enters the scene tree for the first time.


func _on_button_pressed():
	print("started")
	Transition.change_scene()
	await get_tree().create_timer(1).timeout
	Audio.change()
	get_tree().change_scene_to_file("res://Room1/room#1_spawn.tscn")
	Transition.fadeout()
	Audio._start()
	


func _on_ready() -> void:
	if Globalvariables.playing == false:
		Audio._start2()
	

func _on_button_2_pressed() -> void:
	Transition.change_scene()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Credits/credits.tscn")
	Transition.fadeout()


func _on_button_3_pressed() -> void:
	get_tree().quit()
