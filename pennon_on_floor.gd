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
	$AnimationPlayer.play("fadeout")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if entered == true:
		$AnimationPlayer.play("fadein")
		if Input.is_action_just_pressed("Interact"):
			Globalvariables.pennonUnlock = true
			print("pennon unlocked")
			queue_free()
			
		
