extends LevelData

func _enter_tree() -> void:
	level_name = "Digging Deeper"
	sigil_queue = [
		Level.Sigil.A, 
		Level.Sigil.B,
		Level.Sigil.C,
	]
	
	palette = PaletteList.DOGHOUSE
	palette_dark = PaletteList.ATTIC_DARK
	next_level = "res://sokoban-side/levels/1-doghouse/1-4.tscn"
	
	Level.lvl_data = self
	
func _ready() -> void:
	PaletteSwapper.set_palette(palette)
	PaletteSwapper.set_brightness(-1.0)
	PaletteSwapper.tween_to_brightness(0.0, 0.5)

func _exit_tree() -> void:
	Level.lvl_data = null
