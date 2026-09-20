extends LevelData

func _enter_tree() -> void:
	level_name = "The Attic"
	sigil_queue = [
		Level.Sigil.A, 
		Level.Sigil.B,
	]
	
	palette = PaletteList.ATTIC_DARK
	palette_dark = PaletteList.ATTIC
	music_light = "res://music/eldritch3(moody).mp3"
	music_dark = "res://music/eldritch3(darkmoody).mp3"
	next_level = "res://sokoban-side/levels/3-attic/3-2.tscn"
	
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
