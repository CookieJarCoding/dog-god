class_name Interactable
extends Area2D
## For objects that need to keep track of collision with the Player for triggering events
## Optionally accepts an AnimationPlayer to animate the object's sprite when Player is in range


# If a "glowing state" sprite is available
@export var glow_animation: AnimationPlayer = null


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
		if glow_animation:
			glow_animation.play("glow")


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.unregister_interactable(self)
		if glow_animation:
			glow_animation.play("RESET")
