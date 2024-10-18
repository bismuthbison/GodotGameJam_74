extends Node2D

@export var tile_map : TileMapLayer
@export var ray_cast : RayCast2D
@export var step_sound : AudioStream

var equiped_item : GameItem


func _ready() -> void:
	SignalBus.item_is_selected.connect(_hold_item)
#endfunc
	
func _hold_item(item: GameItem):
	equiped_item = item
	prints(equiped_item)
#endfunc

func _process(_delta: float) -> void:
	handleInput()
	
func handleInput() -> void: 
	if Input.is_action_just_pressed("up"):
		move(Vector2i.UP)
	elif Input.is_action_just_pressed("down"):
		move(Vector2i.DOWN)
	elif Input.is_action_just_pressed("left"):
		move(Vector2i.LEFT)
	elif Input.is_action_just_pressed("right"):
		move(Vector2i.RIGHT)

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
	if tile_data.get_custom_data("walkable") == false: #Can the player step there
		#TODO: Add Noise
		print("bonk")
		return
	ray_cast.target_position = direction * Globals.STEP_PIXEL #update the ray cast position
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding(): #did we hit something
		var whatGotHit = ray_cast.get_collider() #what did we hit
		var meta = whatGotHit.get_meta("type") #what is it?
		#check if the object has the meta data of pushable
		if meta == "pushable": #is it a pushable?
			var result = whatGotHit.push(direction,tile_map) #try to push it
			if result == false: 
				return #stop moving if it can't be pushed
		if meta == "chest": #is it an item chest
			whatGotHit.openMe() #open it
			return #but don't move
		if meta == "problem": #is is a problem block?
			whatGotHit.attemptSolution(equiped_item)	 #try to fix the probem		
			return #don't move
		if meta == "npc":
			return whatGotHit.talk()
		if meta == "exit": 
			return whatGotHit.exitLevel()
			
	global_position = tile_map.map_to_local(target_tile) #All else move
	SignalBus.audio_trigger.emit(step_sound)
