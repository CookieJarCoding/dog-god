### NOTE: PaletteSwapper is a GLOBAL scene. Its script can be accessed anywhere,
### and the scene exists in the tree at (almost) all times during runtime.

### NOTE: If you don't have autocomplete for PaletteSwapper methods/variables,
### try reloading the project.

extends Node


@onready var screen_filter := $CanvasLayer/BackBufferCopy/ScreenFilter


func _ready() -> void:
	# NOTE: Placeholder
	change_palette(PaletteList.DOGHOUSE)
	hide_if_missing_palettes()


func hide_if_missing_palettes() -> void:
	if (
		screen_filter.material.get_shader_parameter("source_palette") == null or
		screen_filter.material.get_shader_parameter("target_palette") == null
		):
		screen_filter.hide()


## Changes the target palette. Base palette should not be changed under normal circumstances.
## [br][br]
## Requires a Palette instance. Use PaletteList.<PALETTE_NAME>
func change_palette(new_palette: Palette) -> void:
	screen_filter.material.set_shader_parameter("target_palette", new_palette.texture)
