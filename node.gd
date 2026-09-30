extends Node

var playing = false
var stop = false

# Called when the node enters the scene tree for the first time.
func _start():
	if playing == false:
		$AudioStreamPlayer.play()

func _start2():
	if playing == false:
		Globalvariables.playing = true
		$AudioStreamPlayer2.play()
		
func change():
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.stop()
	Globalvariables.playing = false
	
func Ember():
	$AudioStreamPlayer3.play()
	$AudioStreamPlayer4.play()
	Globalvariables.playing = true
	
func Hit():
	$AudioStreamPlayer5.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
