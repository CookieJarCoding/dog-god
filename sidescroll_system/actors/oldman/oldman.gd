extends Interactable

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
@onready var _dialogue_manager := DialogueManager.get_instance(get_tree())

func interact() -> void:
	if dialogue:
		if _dialogue_manager == null:
			push_error("No DialogueManager defined for this room.")
			return
		var formatted_dialogue := "[color=#1f1f1f]%s[/color]" % dialogue
		_dialogue_manager.load_messages([
			formatted_dialogue
		])
