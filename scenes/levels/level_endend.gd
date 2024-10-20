extends Node2D
func _ready() -> void:
	SignalBus.cue_wind.emit()
	SignalBus.activate_exit.emit()
