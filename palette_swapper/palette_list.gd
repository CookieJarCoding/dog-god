class_name PaletteList

static var BASE: Palette = Palette.new(preload("res://palettes/0-placeholder-palette.png"))
static var HUMAN_BASE: Palette = Palette.new(preload("res://palettes/1-palette-human-base.png"))
static var BACKYARD: Palette = Palette.new(preload("res://palettes/4-palette-doghouse.png"))
static var KITCHEN: Palette = Palette.new(preload("res://palettes/5-palette-kitchen.png"))
static var ATTIC: Palette = Palette.new(preload("res://palettes/6-palette-attic.png"))
static var ATTIC_DARK: Palette = Palette.new(preload("res://palettes/7-palette-attic-dark.png"))

func _init() -> void:
	BASE.name = "Base"
	HUMAN_BASE.name = "Human Base"
	BACKYARD.name = "Backyard"
	KITCHEN.name = "Kitchen"
	ATTIC.name = "Attic"
	ATTIC_DARK.name = "Attic Dark"
