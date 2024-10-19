extends Window
#the exit window 


func _on_pop_up_confirm_pressed():
	SignalBus.try_to_quit_game.emit()
	self.hide()


func _on_pop_up_denied_pressed():
	self.hide()
