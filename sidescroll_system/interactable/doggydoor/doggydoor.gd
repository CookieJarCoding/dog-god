extends Interactable

@onready var sprite = $BaseSprite

@export var next_room: PackedScene

var _is_transitioning := false

func _ready() -> void:
	lit_sprite = $GlowSprite

func interact() -> void:
	if _is_transitioning:
		return
	if next_room == null:
		push_error("No next room defined for this doggy door")
		return

	_is_transitioning = true
	for body in get_overlapping_bodies():
		body.set_physics_process(false)
		break
		
	await PaletteSwapper.tween_to_brightness(0.3, 2)
	RoomLoader.enter_room(next_room)
