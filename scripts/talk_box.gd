extends Label

func _ready() -> void:
	SignalBus.add_item_to_inventory.connect(_display_item_desc)
	SignalBus.update_talkbox.connect(_display_message)

	pass
#end func

func _display_item_desc(item: GameItem):
	if item.description == null:
		#be mean
		self.text = "You forgot to set the resource dummy"
		return
	#end if
	var desc : Dialogue = item.description
	self.text = desc.dialogue_text[0]
#end func

func _display_message(message : String):
	self.text = message
