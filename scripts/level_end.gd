extends Node2D

func _ready() -> void:
	SignalBus.cue_wind.emit()
	pass
