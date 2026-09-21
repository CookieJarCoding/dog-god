extends Interactable

@onready var sprite = $BaseSprite

var _is_enabled = false

func enable_diary() -> void:
	_is_enabled = true
	lit_sprite = $GlowSprite
	for body in get_overlapping_bodies():
		if body == SidescrollPlayer:
			lit_sprite.show()

func interact() -> void:
	if not _is_enabled:
		return
	await PaletteSwapper.tween_to_brightness(1.0, 3.0)
	get_tree().change_scene_to_file("res://sidescroll_system/ending_scene/stay_end.tscn")
	
