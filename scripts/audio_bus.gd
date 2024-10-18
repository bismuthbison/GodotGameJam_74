extends Node

@export var volume_option : PopupMenu

func _ready() -> void:
	SignalBus.audio_trigger.connect(_play_audio)
func _play_audio(sound : String):
	if volume_option.is_item_checked(0) == false:
		return
	match sound:
		"step_sound": 
			$step_sound.play()
		
