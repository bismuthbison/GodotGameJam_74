extends PanelContainer

@export var inventory : ItemList
@export var talk_box : Label
@export var level_progress : ProgressBar

var inventoryItems : Dictionary = {}


var starting_level = preload("res://scenes/game_view.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var levelInstance = starting_level.instantiate()
	%TheGameView.add_child(levelInstance)
	SignalBus.add_item_to_inventory.connect(_add_item_to_inventory)
	#SignalBus.ping_a_problem.connect(_tally_problems)
	
func _add_item_to_inventory(item: GameItem):
	var lineNo = inventory.add_item(item.name, item.image)
	inventoryItems[lineNo] = item
#endfunc

func _on_inventory_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	SignalBus.update_talkbox.emit(str("I am holding the ", inventoryItems[index].name))
	SignalBus.item_is_selected.emit(inventoryItems[index])
	pass # Replace with function body.
