extends Interactable

@onready var sprite = $BaseSprite

var _is_enabled = false

func enable_diary() -> void:
	_is_enabled = true
	lit_sprite = $GlowSprite
	if Player in get_overlapping_bodies():
		lit_sprite.show()

func interact() -> void:
	if not _is_enabled:
		return
	get_tree().change_scene_to_file("res://sidescroll_system/ending_scene/stay_end.tscn")
	
