extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimationPlayer.play("credits")
	await get_tree().create_timer(13.5).timeout
	Transition.change_scene()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Menu/Menu.tscn")
	Transition.fadeout()
