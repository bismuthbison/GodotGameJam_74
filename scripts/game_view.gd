extends Node2D

signal item_pickup
signal ping_the_top

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ping_the_top.emit() #TODO: Get rid of this ping, this was a test
	pass
