extends Area2D
# TODO: Create Interactable class

var interact_dialogue = "This is my doghouse."

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.current_interactable = self

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.current_interactable = null

func print_dialogue() -> void:
	print(interact_dialogue)
