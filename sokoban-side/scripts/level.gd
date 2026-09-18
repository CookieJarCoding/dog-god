extends Node

const TILE_SIZE := Vector2i(16, 16)
const GRID_SIZE := Vector2i(10, 7)

enum Sigil { A, B, C, D, E, F }

var sigil_queue = [] # Contains the queue of sigils

var tile_sigils: Array[TileSigil] = []
var moveables: Array[Moveable] = []
var interactables: Array[Interactable] = []
var tilemap : TileMapLayer

func _ready() -> void:
	get_tree().scene_changed.connect(level_changed)
	level_changed()

func level_changed() -> void:
	tilemap = get_tree().get_first_node_in_group("LevelTileMap")

func get_tile_type(target: Vector2i) -> int:
	if tilemap != null:
		match tilemap.get_cell_source_id(target):
			0:
				return 1
			_:
				return 0
	else:
		return 0
		
func get_sigil_at_tile(tile: Vector2i) -> TileSigil:
	for s in tile_sigils:
		if tile == s.tile:
			return s
	return null
	
func get_interactable_at_tile(tile: Vector2i) -> Interactable:
	for i in interactables:
		if tile == i.tile:
			return i
	return null
	
	
func pop_first_sigil() -> void:
	sigil_queue.pop_front()

func add_sigil_at_front(sigil: Sigil) -> void:
	sigil_queue.push_front(sigil)
	
	
		
