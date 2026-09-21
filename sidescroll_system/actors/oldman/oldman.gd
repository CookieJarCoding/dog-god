extends Interactable

@onready var _dialogue_manager := DialogueManager.get_instance(get_tree())


func _ready() -> void:
	$AnimatedSprite2D.play("idle")

	
func interact() -> void:
	if dialogue:
		if _dialogue_manager == null:
			push_error("No DialogueManager defined for this room.")
			return
		var formatted_dialogue := "[color=#1f1f1f]%s[/color]" % dialogue
		_dialogue_manager.load_messages([
			formatted_dialogue
		])
		await _dialogue_manager.finished
		return
	# Special case for Attic
	if RoomLoader.get_active_phase() == 2:
		await PaletteSwapper.tween_to_brightness(-1.0, 3.0)
		get_tree().change_scene_to_file("res://sidescroll_system/ending_scene/destroy_end.tscn")
