extends CharacterBody2D

var mouse_position = null
var speed = 400
var bector2 = Vector2(1670,1000)

func _physics_process(delta):
	
	mouse_position = get_global_mouse_position()
	position = lerp(position, (mouse_position -Vector2(600,400)), delta * 0.1)
	
	move_and_slide()
	  
