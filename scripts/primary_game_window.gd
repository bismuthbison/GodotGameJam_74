extends PanelContainer

@export var inventory : ItemList
@export var talk_box : Label
@export var level_progress : ProgressBar

var inventoryItems : Dictionary = {}
var problemCount : int = 0
var solvedProblems : int = 0
const levels = [
	preload("res://scenes/game_view.tscn"),
	preload("res://scenes/levels/level_02.tscn"),
]
var current_level = 0
func _ready() -> void:
	var levelInstance = levels[current_level].instantiate()
	%TheGameView.add_child(levelInstance)
	SignalBus.add_item_to_inventory.connect(_add_item_to_inventory)
	SignalBus.reset_problem_count.connect(_reset_problems)
	SignalBus.ping_a_problem.connect(_tally_problems)
	SignalBus.problem_solved.connect(_problem_solved)
	SignalBus.load_next_scene.connect(_load_scene)
func _load_scene(): 
	current_level += 1
	var LevelInstance = levels[current_level].instantiate()
	%TheGameView.get_child(0).queue_free()
	%TheGameView.add_child(LevelInstance)
	_reset_problems()
	clearInventory()
func _reset_problems(): #reset the value
	problemCount = 0
	solvedProblems = 0
	level_progress.value = 0
func _tally_problems(): #tally all the problems
	problemCount += 1
	print(problemCount)
	level_progress.max_value = problemCount
func _problem_solved():
	level_progress.value += 1
	solvedProblems += 1
	if solvedProblems == problemCount:
		SignalBus.activate_exit.emit()
func _add_item_to_inventory(item: GameItem):
	var lineNo = inventory.add_item(item.name, item.image)
	inventoryItems[lineNo] = item
func clearInventory():
	inventory.clear()
func _on_inventory_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	SignalBus.update_talkbox.emit(str("I am holding the ", inventoryItems[index].name))
	SignalBus.item_is_selected.emit(inventoryItems[index])
func _on_close_app_button_pressed():
	get_tree().quit()
