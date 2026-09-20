extends Node2D


func _ready() -> void:
	var dialogue_manager := DialogueManager.get_instance(get_tree())
	if dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return

	dialogue_manager.load_messages([
		"[color=#1f1f1f]Bri? Brioche, where'd you go?[/color]",
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
