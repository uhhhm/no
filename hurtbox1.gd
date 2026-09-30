extends Area2D
var entered = false
signal hitbymob
var hitbuffer = true
var hit = false
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
# Called every frame. 'delta' is the elapsed time since the previous frame.



func _process(_delta):
	if entered == true and hitbuffer == true:
		hitbuffer = false
		$DMGtimer.start()
		Globalvariables.playerHealth -= 15
		hitbymob.emit()


func _on_dm_gtimer_timeout() -> void:
	hitbuffer = true


func _on_area_entered(area) -> void:
	var atkhit := area as Area2D
	if not atkhit:
		return
	hit = true
	print("hit")
