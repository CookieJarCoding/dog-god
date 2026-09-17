extends Area2D
class_name Interactable

# TEMP placeholder for dialogue system
@export var interact_dialogue: String = ""

func interact() -> String:
	return interact_dialogue
###

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.register_interactable(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.unregister_interactable(self)

# TEMP debug only
func print_dialogue() -> void:
	print(interact_dialogue)
###
