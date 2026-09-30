extends Area2D

var entered = false
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

func _process(_delta):
	if entered == true and Globalvariables.inatk == true:
		print("hitmob")
		Globalvariables.hitmob = true
		
		
