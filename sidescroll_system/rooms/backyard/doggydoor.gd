extends Interactable

@onready var sprite = $BaseSprite

func _ready() -> void:
	glow_animation = $GlowSprite/Animation
