extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_playing() == false:
		self.visible = false
		if Input.is_action_just_pressed("atk"):
			Globalvariables.inatk = true
			Audio.Hit()
			if Globalvariables.flip_h == true:
				self.flip_h = false
				self.position.x = -4
			else:
				self.flip_h = true
				self.position.x = -55
			self.visible = true
			self.play("atk")
			await get_tree().create_timer(0.01).timeout
			Globalvariables.inatk = false
			await get_tree().create_timer(0.04).timeout
			
			
	
