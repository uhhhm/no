extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.position = get_viewport_rect().size/2
	if Globalvariables.isPaused == true:
		show()
		get_tree().paused = true
		
	if Globalvariables.isPaused == false:
		hide()


func _on_resume_pressed():
	Globalvariables.isPaused = false
	print("unpaused")
	hide()
	get_tree().paused = false


func _on_quit_pressed() -> void:

	get_tree().quit()
