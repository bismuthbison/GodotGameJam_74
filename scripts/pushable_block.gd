extends StaticBody2D

@export var ray_cast : RayCast2D

#TODO: Add Double PUSH


func push(direction : Vector2i, tile_map : TileMapLayer) -> bool:
	#get current tile
	var currentTile : Vector2i = tile_map.local_to_map(global_position)
	#get destination tile
	var targetTile : Vector2i = Vector2i(
		currentTile.x + direction.x,
		currentTile.y +direction.y
	)
	#check if valid for go to
	var tileData : TileData = tile_map.get_cell_tile_data(targetTile)
	#IF Yes, move and return true
	if tileData.get_custom_data("walkable") == true:
		global_position = tile_map.map_to_local(targetTile)
		prints ("I have been pushed to", targetTile)
		return true
	#end if
	#if no, stay and return false
	prints("Staying here buddy")
	return false
#endfunc
