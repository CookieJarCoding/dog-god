extends Node2D

var _dialogue_manager: DialogueManager
var _is_dialogue_finished = false

func _ready() -> void:
	_dialogue_manager = DialogueManager.get_instance(get_tree())
	if _dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return

	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Bri? Brioche, where'd you go?[/color]",
	])


func _on_dialogue_trigger_area_body_entered(body: Node2D) -> void:
	if _is_dialogue_finished:
		return
	
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Oh there you are![/color]",
		"[color=#1f1f1f]Look at you, digging a hole, are we?[/color]",
		"[color=#1f1f1f]That's impressive, boy![/color]",
		"[color=#1f1f1f]But it's dinnertime, sweetheart. Come on,[/color]",
		"[color=#1f1f1f]let's get you inside before this heat[/color]",
		"[color=#1f1f1f]roasts you, haha![/color]",
		"[color=#1f1f1f]...[/color]",
		"[color=#1f1f1f]This Florida heat is something else, huh?[/color]",
		"[color=#1f1f1f]Brioche growls in annoyance but[/color]",
		"[color=#1f1f1f]eventually gives in because of food.[/color]",
	])
	_is_dialogue_finished = true
	
