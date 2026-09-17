extends Area2D
class_name Interactable

# TEMP placeholder for dialogue system
@export var interact_dialogue: String = ""
func interact() -> String:
	return interact_dialogue
###

# If a "glowing state" sprite is available
@export var glow_animation: AnimationPlayer = null

func _init() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

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

# TEMP debug only
func print_dialogue() -> void:
	print(interact_dialogue)
###
