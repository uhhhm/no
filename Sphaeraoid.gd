extends CharacterBody2D
const SPEED = 300.0

@onready var wall_checker: RayCast2D = $Wallchecker
@onready var player_checker: RayCast2D = $Playerchecker
@onready var ground_checker: RayCast2D = $Groundchecker

var state = "idle"
var direction = -1
var health = 50


func _physics_process(delta: float) -> void:
	if direction == -1:
		$AnimatedSprite2D.flip_h = false
		player_checker.set_rotation_degrees(0)
		wall_checker.set_rotation_degrees(0)
		ground_checker.scale.x *= -1
	else:
		$AnimatedSprite2D.flip_h = true
		player_checker.set_rotation_degrees(180)
		wall_checker.set_rotation_degrees(180)
		ground_checker.scale.x *= -1
	# Add the gravity.
	if player_checker.is_colliding():
		state = "idle"
	
	elif wall_checker.is_colliding():
		direction *= -1
	
	elif not ground_checker.is_colliding():
		direction *= -1

	elif not wall_checker.is_colliding() and not player_checker.is_colliding():
		state = "walk"
	else:
		state = "idle"
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if state == "idle":
		$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	
	if state == "walk":
		$AnimatedSprite2D.play("Walk")
		velocity.x = 20 * direction
		$Walktimer.start()
		if $Walktimer.is_stopped():
			state = "idle"
			await get_tree().create_timer(1.5).timeout
			direction *= -1
			state = "walk"
	
	if Globalvariables.hitmob == true:
		health -= 5
		Globalvariables.hitmob = false
		velocity.y -= 100
		$AnimationPlayer.play("onhit")
	
	if health <= 0: 
		queue_free()
	

	move_and_slide()


func _on_walktimer_timeout() -> void:
	pass
	
	
