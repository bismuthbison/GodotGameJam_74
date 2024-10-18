extends Window



func _on_pop_up_confirm_pressed():
	get_tree().quit()


func _on_pop_up_denied_pressed():
	self.hide()
