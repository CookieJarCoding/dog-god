extends LevelData

func _enter_tree() -> void:
	level_name = "Canned Goods"
	sigil_queue = [
		Level.Sigil.A, 
	]
	
	palette = PaletteList.KITCHEN
	palette_dark = PaletteList.ATTIC_DARK
	next_level = "res://sokoban-side/levels/2-kitchen/kitchen_level_4.tscn"
	
	Level.lvl_data = self
	
func _ready() -> void:
	PaletteSwapper.set_palette(palette)
	PaletteSwapper.set_brightness(-1.0)
	PaletteSwapper.tween_to_brightness(0.0, 0.5)

func _exit_tree() -> void:
	Level.lvl_data = null
