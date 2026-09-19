class_name Palette

## Optional
var name: String
var texture: Texture2D

## Palette Constructors
func _init(palette_image: Texture2D) -> void:
	texture = palette_image

func get_name() -> String:
	return name
