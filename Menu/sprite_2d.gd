extends Sprite2D

var mouse_position = null
var speed = 200
var velocity = Vector2()

func _physics_process(delta) -> void:
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	velocity = (direction * speed)
	
	
	
