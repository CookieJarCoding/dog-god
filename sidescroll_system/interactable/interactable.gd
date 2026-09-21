class_name Interactable
extends Area2D
## For objects that need to keep track of collision with the Player for triggering events
## Optionally accepts a Sprite2D to show a "lit up" state when Player is in range

# If the Interactable plainly triggers short one-line dialogue
@export var dialogue: String = ""
# If a "glowing state" sprite is available
@export var lit_sprite: Sprite2D = null
# If a "glowing state" animated sprite is available
@export var lit_sprite_animated: AnimatedSprite2D = null


func _init() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func interact() -> void:
	# Shared function for all Interactables.
	# Subclasses with specific interactions must override this method.
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is SidescrollPlayer:
		body.register_interactable(self)
		if lit_sprite:
			lit_sprite.show()
		if lit_sprite_animated:
			lit_sprite_animated.show()


func _on_body_exited(body: Node2D) -> void:
	if body is SidescrollPlayer:
		body.unregister_interactable(self)
		if lit_sprite:
			lit_sprite.hide()
		if lit_sprite_animated:
			lit_sprite_animated.hide()
