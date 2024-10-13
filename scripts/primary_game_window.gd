extends PanelContainer

var itemsDict = {
	"Saw": "res://assets/items/saw.png",
	"Wrench" : "res://assets/items/wrench.png",
	"Paint Roller":"res://assets/items/paintroller.png"
}

@export var inventory : ItemList

var starting_level = preload("res://scenes/game_view.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var levelInstance = starting_level.instantiate()
	%TheGameView.add_child(levelInstance)
	levelInstance.ping_the_top.connect(_got_pinged)
	pass
#end func


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#updated the delta comment

#TODO: Remove default windows bracket

func _got_pinged() -> void:
	print("pinged")


func _on_inventory_list_item_activated(index: int) -> void:
	
	pass # Replace with function body.
