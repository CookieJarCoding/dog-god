extends Interactable

@export var is_full := true

@onready var _sprite: Sprite2D = $BaseSprite 

func _ready() -> void:
	_set_bowl_sprite(is_full)
	glow_animation = $GlowSprite/Animation


func interact() -> void:
	print("dogbowl")


func _set_bowl_sprite(full: bool) -> void:
	_sprite.frame = 0 if full else 2
