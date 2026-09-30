extends AudioStreamPlayer


const fdmusic = preload("res://Music/The Most Prestigious Dumpster.wav")
const menumusic = preload("res://Music/From the Ashes.wav")
# Called when the node enters the scene tree for the first time.
func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	AudioPlayer.stream = fdmusic
	volume_db = volume
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_music_level():
	_play_music(fdmusic)
	
func play_menu_music():
	_play_music(menumusic)
