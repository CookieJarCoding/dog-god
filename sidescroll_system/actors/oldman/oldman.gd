extends Interactable

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func interact() -> void:
	print("This is Peter.")
