extends StaticBody2D

enum {CHEST_OPEN, CHEST_CLOSE}

@export var contents : GameItem
@export var chestOpenSprite : Sprite2D
@export var chestClosedSprite : Sprite2D

var state = CHEST_CLOSE

func openMe() -> GameItem:
	#if is closed
	if state == CHEST_CLOSE:
		#open the chest visually
		chestClosedSprite.visible = false
		chestOpenSprite.visible = true
		#update the stated
		state = CHEST_OPEN
		#send the contents
		prints("Here is a ", contents.name)
		return contents
	#endif
	#return nothing
	return null
