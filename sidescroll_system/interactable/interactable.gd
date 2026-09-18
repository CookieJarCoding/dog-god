class_name Interactable
extends Area2D
## For objects that need to keep track of collision with the Player for triggering events
## Optionally accepts a Sprite2D to show a "lit up" state when Player is in range


# If a "glowing state" sprite is available
@export var lit_sprite: Sprite2D = null


func _init() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func interact() -> void:
	# Shared function for all Interactables.
	# Subclasses with specific interactions must override this method.
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.register_interactable(self)
		if lit_sprite:
			lit_sprite.show()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.unregister_interactable(self)
		if lit_sprite:
			lit_sprite.hide()
