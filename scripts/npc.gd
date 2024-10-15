extends Node2D

@export var speach : Dialogue
@export var look : Texture2D
@export var who_am_i: String

func _ready() -> void:
	if look != null:
		$Sprite2D.texture = look

func talk() -> bool:
	SignalBus.update_talkbox.emit(speach.get_next_line_text(), who_am_i)
	return false
