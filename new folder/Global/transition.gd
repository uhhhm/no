extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var AreaTitle: Sprite2D = $Img1753
func change_scene():
	Globalvariables.transitioning = true
	var tree := get_tree()
	$AnimationPlayer.play("new_animation")
	await tree.tree_changed
	

func fadeout():
	Globalvariables.transitioning = true
	print("fade")
	var tree := get_tree()
	await tree.tree_changed	
	$AnimationPlayer.play("fade_out")
	
func EnteringFD():
	print("entering")
	$AudioStreamPlayer.play()
	$AnimationPlayer2.play("areatitle")
	
func FDCET():
	$VideoStreamPlayer.play()

func Emberin():
	$AudioStreamPlayer.play()
	$EmberArea.play("Ember")
