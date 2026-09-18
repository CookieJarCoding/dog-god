extends Interactable

@onready var sprite = $BaseSprite

func _ready() -> void:
	lit_sprite = $GlowSprite
