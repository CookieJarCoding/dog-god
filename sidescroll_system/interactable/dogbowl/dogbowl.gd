extends Interactable

@export var is_full := true

@onready var _sprite = $BaseSprite

func _ready() -> void:
	lit_sprite = $GlowSprite
	_set_bowl_full(is_full)


func interact() -> void:
	_set_bowl_full(false)


func _set_bowl_full(full: bool) -> void:
	_sprite.frame = 0 if full else 2
	lit_sprite.frame = 1 if full else 3
