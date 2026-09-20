extends LevelData

func _enter_tree() -> void:
	level_name = "In the Doghouse"
	sigil_queue = [
		Level.Sigil.A, 
		Level.Sigil.B,
	]
	
	palette = PaletteList.DOGHOUSE
	palette_dark = PaletteList.ATTIC_DARK
	music_light = "res://music/eldritch1.mp3"
	music_dark = "res://music/eldritch3(dark).mp3"
	next_level = "res://sokoban-side/levels/1-doghouse/1-2.tscn"
	
	Level.lvl_data = self
	
func _ready() -> void:
	MusicHandler.set_music_light(music_light)
	MusicHandler.set_music_dark(music_dark)
	MusicHandler.switch_to_light()

	PaletteSwapper.set_palette(palette)
	PaletteSwapper.set_brightness(-1.0)
	PaletteSwapper.tween_to_brightness(0.0, 0.5)

func _exit_tree() -> void:
	Level.lvl_data = null
