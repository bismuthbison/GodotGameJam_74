extends StaticBody2D

@export var ray_cast : RayCast2D

#TODO: Add Double PUSH

func push(direction : Vector2i, tile_map : TileMapLayer) -> bool:
	#get current tile
	var currentTile : Vector2i = tile_map.local_to_map(global_position)
	#get destination tile
	var targetTile : Vector2i = Vector2i(
		currentTile.x + direction.x,
		currentTile.y + direction.y
	)
	#update ray cast direction anyways
	prints("create is going",direction)
	ray_cast.target_position = direction * Globals.STEP_PIXEL # Since this variable is used through out the project
	ray_cast.force_raycast_update() #the raycast won't update till next frame if this isn't here
	#check if valid for go to
	var tileData : TileData = tile_map.get_cell_tile_data(targetTile)
	if tileData.get_custom_data("walkable") == true: #can the block be pushed onto the tile?
		# prints ("I have been pushed to", targetTile) 
		if ray_cast.is_colliding() == true: #is there something in the way?
			var whatGotHit = ray_cast.get_collider()
			var meta = whatGotHit.get_meta("type")
			if meta == "pushable": #is it a pushable object
				prints("Pushing another block")
				var results = whatGotHit.push(direction, tile_map) #try to push it
				if results == true:
					move(targetTile, tile_map)
				else: 
					return false	
			else: #is there an different object in the way?
				return false #Just stop
		move(targetTile,tile_map)
		return true #I got pushed
	#if no, stay and return false
	#prints("Staying here buddy")
	return false
#endfunc
func move(target_tile : Vector2i, tile_map : TileMapLayer ):
	global_position = tile_map.map_to_local(target_tile)
	
