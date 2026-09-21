extends LevelData

func _enter_tree() -> void:
	level_name = "Shadow of a Doubt"
	sigil_queue = [
		Level.Sigil.D,
		Level.Sigil.C,
		Level.Sigil.A, 
		Level.Sigil.C,
		Level.Sigil.D,
		Level.Sigil.F,
	]
	
	palette = PaletteList.ATTIC_DARK
	palette_dark = PaletteList.ATTIC
	next_level = "res://sokoban-side/levels/3-attic/3-6.tscn"
	
	Level.lvl_data = self
	
func _ready() -> void:
	MusicHandler.switch_to_light()

	PaletteSwapper.set_palette(palette)
	PaletteSwapper.set_brightness(-1.0)
	PaletteSwapper.tween_to_brightness(0.0, 0.5)

func _exit_tree() -> void:
	Level.lvl_data = null
