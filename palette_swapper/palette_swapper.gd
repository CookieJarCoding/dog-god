### NOTE: PaletteSwapper is a GLOBAL scene. Its script can be accessed anywhere,
### and the scene exists in the tree at (almost) all times during runtime.

### NOTE: If you don't have autocomplete for PaletteSwapper methods/variables,
### try reloading the project.

extends Node

signal tween_done

@onready var screen_filter := $CanvasLayer/BackBufferCopy/ScreenFilter

var current_palette: Palette
var tween


func _ready() -> void:
	# NOTE: Placeholder
	set_palette(PaletteList.HUMAN_BASE)
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
func set_palette(new_palette: Palette) -> void:
	current_palette = new_palette
	screen_filter.material.set_shader_parameter("target_palette", new_palette.texture)


## Range of valid brightness: [-1, 1]
## [br][br]
## Values outside this range are automatically clamped.
func set_brightness(new_brightness: float) -> void:
	new_brightness = clampf(new_brightness, -1, 1)
	screen_filter.material.set_shader_parameter("brightness", new_brightness)


func tween_to_brightness(new_brightness: float, duration: float) -> void:
	new_brightness = clampf(new_brightness, -1, 1)
	if tween:
		return
	
	tween = create_tween()
	tween.tween_property(screen_filter.material, "shader_parameter/brightness", new_brightness, duration)
	
	await tween.finished
	tween_done.emit()
	tween.kill()
	tween = null



'''
Getters
'''

func get_current_brightness() -> float:
	return screen_filter.material.get_shader_parameter("brightness")


func get_current_palette_name() -> String:
	return current_palette.get_name()
