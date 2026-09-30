extends CharacterBody2D

const SPEED = 190.0
const JUMP_VELOCITY = -600.0
const DASH_VELOCITY = 700.0
var dashing = false
var can_dash = true
var can_djump = true
var newroom = 0
var oldroom = 0
var roomNum = 0
var bonkDir = Vector2(1,0)
const BONK = preload("res://Untitled_Artwork 8.png") 
var direction
var gliding = false
var health = 100
var leftfacing = 0
var walkaudio = 1
var windlevel = RandomNumberGenerator.new()
@onready var Pennon : AnimatedSprite2D = $Pennon

func _ready():
	Globalvariables.transitioning = false
	print(Globalvariables.playing)
	set_floor_max_angle(0.7854)
	$CanvasLayer2/Healthbar._init_health(health)
	$Pennon.visible = false
	$Camera2D.set_position_smoothing_enabled(false)
	print("directionkeep", Globalvariables.directionkeep)
	if Globalvariables.directionkeep == false:
		$AnimatedSprite2D.flip_h = false
	elif Globalvariables.directionkeep == true:
		$AnimatedSprite2D.flip_h = true
	print(get_tree().current_scene.name)
	if get_tree().current_scene.name == "Room2":
		roomNum = 2
	if get_tree().current_scene.name == "TEST" and Globalvariables.oldroom != 4:
		roomNum = 1
		velocity.y = -600
	if get_tree().current_scene.name == "Ember Room #1" and Globalvariables.embernew == true:
		Transition.Emberin()
		Globalvariables.embernew = false
	if (get_tree().current_scene.name == "Ember Room #1" or get_tree().current_scene.name == "Ember Room #2" or get_tree().current_scene.name == "Ember Room #3") and Globalvariables.playing == false:
		Audio.change()
		Audio.Ember()
	print(oldroom)
	if Globalvariables.oldroom == 1:
		self.position = Vector2(1117, 1581)
	if Globalvariables.oldroom == 2:
		self.position = Vector2(-270, 1180)
	if Globalvariables.oldroom == 4:
		self.position = Vector2(1850, -540 )
	if Globalvariables.oldroom == 5:
		self.position = Vector2(1190, -180)
	if Globalvariables.oldroom == 7:
		self.position = Vector2(1360, 700)
	if Globalvariables.oldroom == 8:
		self.position = Vector2(2250, 560)
	Globalvariables.oldroom = 0
	await get_tree().create_timer(0.4).timeout
	$Camera2D.set_position_smoothing_enabled(true)

func _physics_process(delta: float) -> void:
	health = Globalvariables.playerHealth
	if health > 0:
		$CanvasLayer2/Healthbar._set_health(health)
	elif health <= 0:
		pass
	
	# Add the gravity.
	direction = Input.get_axis("ui_left", "ui_right")
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor() or is_on_wall(): 
		can_djump = true
		$Pennon.visible = false
		gliding = false		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and can_djump:
			velocity.y = JUMP_VELOCITY 
			if is_on_wall():
				velocity.x = direction * SPEED * -20
			can_djump = false
			
	if is_on_wall() and Input.is_action_just_pressed("ui_accept"):
		velocity.x = move_toward(velocity.x, -1, SPEED) 
		velocity.y = JUMP_VELOCITY
	
	if Globalvariables.inatk == true:
		velocity.x = move_toward(velocity.x, -0.5, direction) 
		velocity.y *= 0.5
		await get_tree().create_timer(0.05).timeout

	# Get the input direction and handle the movement/deceleration.
	
	if $Pennon.visible == false:
		#if glider is not visible, normal player movements
		if direction:
			velocity.x = direction * SPEED
		elif velocity.y == 0:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			$AnimatedSprite2D.play("default")
			velocity.x = lerp(velocity.x, 0.0, 0.2)
		elif velocity.y != 0:
			velocity.x = move_toward(velocity.x, 0, SPEED) 
		
	if not is_on_floor():
		if velocity.x > 400:
			velocity.x = 400
		if velocity.x < -400:
			velocity.x = -400
	
	if Input.is_action_just_pressed("dash") and can_dash:
			dashing = true
			can_dash = false
			$dash_time.start()
			$dash_ag.start()
			velocity.y = -0.1 * velocity.y
			
	if Input.is_action_pressed("Glide") and not is_on_floor() and gliding == false and not is_on_wall() and Globalvariables.pennonUnlock == true:
		gliding = true
		print(gliding)
		$Pennon.visible = true
		if $AnimatedSprite2D.flip_h == false:
			$Pennon.flip_h = true
		else: 
			$Pennon.flip_h = false
		$Pennon.play("Deploy")	
		
	if gliding == true and Input.is_action_just_released("Glide") and Globalvariables.pennonUnlock == true:
		$Pennon.play_backwards("Deploy")
		gliding = false
		print(gliding)
		print($Pennon.get_frame())
		if $Pennon.get_frame() == 0:
			$Pennon.visible = false
	
	if gliding == true and not is_on_floor() and Globalvariables.pennonUnlock == true:
		velocity.y = velocity.y * windlevel.randf_range(0.65, 0.75)
		$Pennon.rotation_degrees = windlevel.randf_range(0.5, -0.5)
		
		if $AnimatedSprite2D.flip_h == false:
			velocity.x = -45 * SPEED * delta
			$Pennon.flip_h = true
		else: 
			velocity.x = 45 * SPEED * delta
			$Pennon.flip_h = false
			
	if direction < 0:
		$AnimatedSprite2D.flip_h = false
		leftfacing = -1
	elif direction > 0:
		$AnimatedSprite2D.flip_h = true
		leftfacing = 1
		
	if direction and velocity.y == 0 and velocity.x != 0: 
		$AnimatedSprite2D.play("Walk")
		if $Walk2.is_playing() == false and velocity.x <= 300:
				$Walk2.play()
		
	if dashing:
		velocity.x = leftfacing * DASH_VELOCITY
		$AnimatedSprite2D.play("dash")
	
	if not is_on_floor() and velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	elif not is_on_wall() and not is_on_floor():
		$AnimatedSprite2D.play("fall")
		
	if Input.is_action_just_pressed("reset"):
		position.x = 0
		position.y = -4000
		velocity.y = 0
		
	if velocity.y >= 720:
		velocity.y = 720

		
	if is_on_wall() and not is_on_floor():
		if not Input.is_action_pressed("ui_accept"):
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				if velocity.y > 0:
					$AnimatedSprite2D.play("Wall Cling")
					velocity.y = velocity.y * 0.85
	
	if Input.is_action_just_released("ui_accept") and not is_on_wall():
		jump_cut()
	
	if Input.is_action_just_pressed("Pause"):
		Globalvariables.isPaused = true
	
		
	if Globalvariables.transitioning == true:
		print("yes")
		if Globalvariables.oldroom == 0:
			velocity.x *= 0
			velocity.y *= 0
			$AnimatedSprite2D.flip_h = $AnimatedSprite2D.flip_h
	
	Globalvariables.flip_h = $AnimatedSprite2D.flip_h
	
	move_and_slide()

func _on_dash_time_timeout() -> void:
	dashing = false
	
func _on_dash_ag_timeout() -> void:
	can_dash = true
	
func jump_cut():
	if velocity.y < -100:
		velocity.y = velocity.y * 0.2

func _on_player_detector_rm_11_enter_room_2_from_1() -> void:
	print("recieved")
	$Camera2D.set_position_smoothing_enabled(false)
	Globalvariables.oldroom = 2
	Globalvariables.directionkeep = true


func _on_player_detector_6_enter_room_3_from_4() -> void:
	print("recieved")
	$Camera2D.set_position_smoothing_enabled(false)
	Globalvariables.oldroom = 4
	Globalvariables.directionkeep = false
	
func _on_player_detector_3_enter_room_1() -> void:
	print("recieved")
	Globalvariables.oldroom = 1
	$Camera2D.set_position_smoothing_enabled(false)

func _on_player_detector_8_enter_room_4_from_5() -> void:
	print("recieved")
	$Camera2D.set_position_smoothing_enabled(false)
	Globalvariables.oldroom = 5
	Globalvariables.directionkeep = false


func _on_hurtbox_hitbymob() -> void:
	if $AnimatedSprite2D.flip_h == false:
		velocity.y = -300
		velocity.x += 400
	if $AnimatedSprite2D.flip_h == true:
		velocity.y = -300
		velocity.x += -400


func _on_player_detector_e_4_enter_roome_2_frome_3() -> void:
	print("recieved")
	$Camera2D.set_position_smoothing_enabled(false)
	Globalvariables.oldroom = 8
	Globalvariables.directionkeep = false
