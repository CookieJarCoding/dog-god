extends LevelData

func _enter_tree() -> void:
	level_name = "Idolatry"
	sigil_queue = [
		Level.Sigil.B, 
		Level.Sigil.A, 
		Level.Sigil.D, 
		Level.Sigil.A, 
		Level.Sigil.B, 
		Level.Sigil.F, 
	]
	
	palette = PaletteList.ATTIC_DARK
	palette_dark = PaletteList.ATTIC
	next_level = "res://sokoban-side/levels/3-attic/dummy.tscn"
	
	Level.lvl_data = self
	
func _ready() -> void:
	MusicHandler.switch_to_light()

	PaletteSwapper.set_palette(palette)
	PaletteSwapper.set_brightness(-1.0)
	PaletteSwapper.tween_to_brightness(0.0, 0.5)

func _exit_tree() -> void:
	Level.lvl_data = null
