extends Node

@export var volume_option : PopupMenu

func _ready() -> void:
	SignalBus.audio_trigger.connect(_play_audio)
	SignalBus.activate_exit.connect(_play_exit_audio)
func _play_audio(sound : AudioStream):
	if volume_option.is_item_checked(0) == false:
		return
	$sound_to_play.stream = sound
	$sound_to_play.play()
	#passing the audio files via the connection bus is fine for one off noises
	#however this might play at the same time so I just making sure it fits
func _play_exit_audio():
	if volume_option.is_item_checked(0) == false:
		return
	$exit_sound.play() 
