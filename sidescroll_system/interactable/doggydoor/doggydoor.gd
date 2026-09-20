extends Interactable

@onready var sprite = $BaseSprite

@export var next_room: PackedScene

func _ready() -> void:
	lit_sprite = $GlowSprite

func interact() -> void:
	if next_room == null:
		push_error("No next room defined for this doggy door")
		return
	RoomLoader.enter_room(next_room)
