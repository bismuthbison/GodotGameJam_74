extends Node2D

@export var tile_map : TileMapLayer
@export var ray_cast : RayCast2D

var equiped_item : GameItem

const STEP_PIXEL = 16


func _ready() -> void:
	SignalBus.item_is_selected.connect(_hold_item)
#endfunc
	
func _hold_item(item: GameItem):
	equiped_item = item
	prints(equiped_item)
#endfunc

func _process(_delta: float) -> void:
	handleInput()
#end func
func handleInput() -> void: 
	if Input.is_action_just_pressed("up"):
		move(Vector2i.UP)
	elif Input.is_action_just_pressed("down"):
		move(Vector2i.DOWN)
	elif Input.is_action_just_pressed("left"):
		move(Vector2i.LEFT)
	elif Input.is_action_just_pressed("right"):
		move(Vector2i.RIGHT)
	#end if
#end func

func move(direction: Vector2i):
	# Get current tile vector2i
	var current_tile : Vector2i = tile_map.local_to_map(global_position)
	# get target tile Vector2i
	var target_tile : Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)
	#prints(current_tile, target_tile) - Keep for debugging
	#get custom data layer from the target tile
	var tile_data : TileData = tile_map.get_cell_tile_data(target_tile)
	
	if tile_data.get_custom_data("walkable") == false:
		#TODO: Add Noise
		print("bonk")
		return
	#end if
	ray_cast.target_position = direction * STEP_PIXEL
	ray_cast.force_raycast_update()
	
	if ray_cast.is_colliding():
		var whatGotHit = ray_cast.get_collider()
		var meta = whatGotHit.get_meta("type")
		#check if the object has the meta data of pushable
		if meta == "pushable": 
			var result = whatGotHit.push(direction,tile_map)
			#try to push object in same direction, 
			if result == false:
				return
			#endif
		if meta == "chest":
			whatGotHit.openMe()
			return
		#endif
		if meta == "problem":
			whatGotHit.attemptSolution(equiped_item)
			
			return
		#endif
	#end if
	#move player
	global_position = tile_map.map_to_local(target_tile)
	pass
#end func
