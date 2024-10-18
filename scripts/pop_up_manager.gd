extends Node

@export var quitPopUp : Window


func _ready():
	#connect the pop ups to the signal bus
	SignalBus.try_to_quit_game.connect(_quitBox)
	pass
	
func _quitBox():
	quitPopUp.show()
