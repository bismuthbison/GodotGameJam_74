extends StaticBody2D

enum {CHEST_OPEN, CHEST_CLOSE}

@export var contents : GameItem
@export var chestOpenSprite : Sprite2D
@export var chestClosedSprite : Sprite2D

var state = CHEST_CLOSE

func openMe() -> void:
	#if is closed
	if state == CHEST_CLOSE:
		#open the chest visually
		chestClosedSprite.visible = false
		chestOpenSprite.visible = true
		#update the stated
		state = CHEST_OPEN
		#send the contents
		SignalBus.add_item_to_inventory.emit(contents)
	elif state == CHEST_OPEN:
		SignalBus.update_talkbox.emit("The Chest is Empty")
	#endif
#endfunc
