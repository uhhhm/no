extends ProgressBar


var health = 0 : set = _set_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _init_health(_health):
	health = _health
	max_value = health
	$DMGbar.max_value = health
	$DMGbar.value = health
	
func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
	
	if health < prev_health:
		$Timer.start()
	else:
		$DMGbar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_timer_timeout() -> void:
	$DMGbar.value = health
