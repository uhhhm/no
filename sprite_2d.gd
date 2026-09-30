extends Sprite2D

@export var speed = 200

var direction:Vector2

func set_direction(ProjDir):
	direction = ProjDir
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))
	
func _physics_process(delta):
	global_position += direction * speed * delta

func _on_ground(body):
	if body.is_on_floor:
		queue_free()
