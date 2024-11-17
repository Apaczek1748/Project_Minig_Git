extends Node2D

@onready var tile_map: TileMapLayer = $TileMap/Layer0

func _ready() -> void:
	pass 

const ADJ_VECS = [Vector2i(0,1), Vector2i(0,-1), Vector2i(1,0), Vector2i(-1,0), Vector2i(1,1), Vector2i(-1,1), Vector2i(1,-1), Vector2i(-1,-1),]
func _input(event):
	if Input.is_action_just_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var cell = tile_map.local_to_map(mouse_pos)
		if cell != null:
			var cellsToUpdate = []
			tile_map.set_cell(cell, -1)
			for nebCell in ADJ_VECS:
				if tile_map.get_cell_tile_data(cell + nebCell) != null:
					cellsToUpdate.append(cell + nebCell)
			tile_map.set_cells_terrain_connect([cell], 0, -1, true)
