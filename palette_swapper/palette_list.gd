class_name PaletteList

static var BASE: Palette = Palette.new(preload("res://palettes/0-placeholder-palette.png"))
static var DOGHOUSE: Palette = Palette.new(preload("res://palettes/4-palette-doghouse.png"))
static var KITCHEN: Palette = Palette.new(preload("res://palettes/5-palette-kitchen.png"))
static var ATTIC: Palette = Palette.new(preload("res://palettes/6-palette-attic.png"))
static var ATTIC_DARK: Palette = Palette.new(preload("res://palettes/7-palette-attic-dark.png"))

func _init() -> void:
	BASE.name = "Base"
	DOGHOUSE.name = "Dog House"
	KITCHEN.name = "Kicthen"
	ATTIC.name = "Attic"
	ATTIC_DARK.name = "Attic_Dark"
