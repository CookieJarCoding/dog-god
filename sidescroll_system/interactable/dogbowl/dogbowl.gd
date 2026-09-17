extends Interactable

@export var isFull := true

@onready var sprite = $BaseSprite

func _ready() -> void:
	set_bowl_sprite(isFull)
	glow_animation = $GlowSprite/Animation

func set_bowl_sprite(full: bool) -> void:
	sprite.frame = 0 if full else 2
