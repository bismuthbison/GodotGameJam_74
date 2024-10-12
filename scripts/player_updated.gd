extends CharacterBody2D

@export var tile_map : TileMapLayer

const STEP_PIXEL = 16

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		move(Vector2.UP)
	elif Input.is_action_just_pressed("down"):
		move(Vector2.DOWN)
	elif Input.is_action_just_pressed("left"):
		move(Vector2.LEFT)
	elif Input.is_action_just_pressed("right"):
		move(Vector2.RIGHT)
	#end if
	
#end func

func move(direction: Vector2):
	# Get current tile vector2i
	var current_tile : Vector2i = tile_map.local_to_map(global_position)
	# get target tile Vector2i
	var target_tile : Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)
	prints(current_tile, target_tile)
	#get custom data layer from the target tile
	var tile_data : TileData = tile_map.get_cell_tile_data(target_tile)
	
	if tile_data.get_custom_data("walkable") == false:
		print("bonk")
		return
	#end if
	#move player
	global_position = tile_map.map_to_local(target_tile)
	pass
#end func
