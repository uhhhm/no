extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Globalvariables.FDdiscovered == false:
		print("playing areatitle")
		Transition.EnteringFD()
		Globalvariables.FDdiscovered = true


func _on_dash_time_timeout() -> void:
	pass # Replace with function body.


func _on_dash_ag_timeout() -> void:
	pass # Replace with function body.
