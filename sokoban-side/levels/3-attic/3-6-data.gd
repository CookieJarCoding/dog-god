extends LevelData

func _enter_tree() -> void:
	level_name = "Ghost Writing"
	sigil_queue = [
		Level.Sigil.D,
		Level.Sigil.A,
		Level.Sigil.C,
		Level.Sigil.B,
		Level.Sigil.F,
	]
	
	palette = PaletteList.ATTIC_DARK
	palette_dark = PaletteList.ATTIC
	music_light = "res://music/eldritch3.mp3"
	music_dark = "res://music/eldritch3(dark).mp3"
	next_level = "res://sokoban-side/levels/3-attic/3-7.tscn"
	
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
