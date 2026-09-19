class_name PaletteList

static var BASE: Palette = Palette.new(preload("res://palettes/0-placeholder-palette.png"))
static var DOGHOUSE: Palette = Palette.new(preload("res://palettes/4-palette-doghouse.png"))

func _init() -> void:
	BASE.name = "Base"
	DOGHOUSE.name = "Dog House"
