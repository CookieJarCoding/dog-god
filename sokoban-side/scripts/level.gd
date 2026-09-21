extends Node

const TILE_SIZE := Vector2i(16, 16)
const GRID_SIZE := Vector2i(10, 7)
const QUEUE_LIMIT := 6

enum Sigil { A, B, C, D, E, F }

var lvl_data : LevelData 
var sigil_queue : SigilQueue = null # main container for sigil queue

var tile_sigils: Array[TileSigil] = []
var moveables: Array[Moveable] = []
var sigil_papers: Array[SigilPaper] = []
var interactables: Array[Interactable] = []
var tilemap : TileMapLayer
var camera : Camera2D = null
var player : Player = null

var is_won = false

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
			4:
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
	
func flip() -> void:
	if camera.position.y <= 16*9/2:
		camera.set_to_dark()
		player.set_pos(Vector2i(player.tile.x, player.tile.y + 9))
		for p in sigil_papers:
			p.set_pos(Vector2i(p.tile.x, p.tile.y + 9))
			p.flip_activity()
		PaletteSwapper.set_palette(lvl_data.palette_dark)
		PaletteSwapper.set_brightness(0)
		MusicHandler.switch_to_dark()
	else:
		camera.set_to_light() 
		player.set_pos(Vector2i(player.tile.x, player.tile.y - 9))
		for p in sigil_papers:
			p.set_pos(Vector2i(p.tile.x, p.tile.y - 9))
			p.flip_activity()
		PaletteSwapper.set_palette(lvl_data.palette)
		PaletteSwapper.set_brightness(0.0)
		MusicHandler.switch_to_light()
	

func get_first_at_queue() -> Level.Sigil:
	return sigil_queue.queue[0].sigil

func pop_first_sigil() -> void:
	sigil_queue.pop_first_at_queue()

func add_sigil_at_front(sigil: Sigil) -> void:
	sigil_queue.add_sigil_at_front(sigil)
	
func restart() -> void:
	await fade_to_black()

	is_won = false	
	get_tree().reload_current_scene()

func if_win() -> bool:
	
	var x = 0
	for s in tile_sigils:
		if s.is_lit:
			x += 1
	
	return x >= len(tile_sigils)
	
func fade_to_black() -> void:
	PaletteSwapper.tween_to_brightness(-1.0, 0.5)
	await get_tree().create_timer(0.5).timeout
	
func start_next_level() -> void:
	MusicHandler.level_complete.play()
	await fade_to_black()

	
	if lvl_data.next_level == "":
		#RoomLoader.exit_sokoban() # external code that terminates the sokoban section after the final level
		pass
	
	else:
		get_tree().change_scene_to_file(lvl_data.next_level)
	

		
