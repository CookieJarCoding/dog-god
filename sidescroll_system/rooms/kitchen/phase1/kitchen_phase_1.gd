extends Node2D

var _dialogue_manager: DialogueManager

func _ready() -> void:
	OverworldMusic.play_human_music()
	_dialogue_manager = DialogueManager.get_instance(get_tree())
	if _dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return
	
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]My, my, Brioche![/color]",
		"[color=#1f1f1f]You basically inhaled your food! Hehe.[/color]",
		"[color=#1f1f1f]I guess all that running around earlier[/color]",
		"[color=#1f1f1f]worked up your appetite.[/color]",
		"[color=#1f1f1f]Brioche aggressively bites the dog bowl as if[/color]",
		"[color=#1f1f1f]to eat it.[/color]",
		"[color=#1f1f1f]Hey, hey, no. The bowl stays. You can't eat that.[/color]",
		"[color=#1f1f1f]Pita chuckles.[/color]",
		"[color=#1f1f1f]Brioche rolls her eyes.[/color]",
	])
	await _dialogue_manager.finished
	$Boof.play()
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Boof![/color]",
	])
	await _dialogue_manager.finished
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Pita yawns.[/color]",
		"[color=#1f1f1f]C'mon boy, let's hit the sack, whaddouyou think?[/color]",
	])
	await _dialogue_manager.finished
	$Boof.play()
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Boof.[/color]",
		"[color=#1f1f1f](Alas, I could not consume more of this)[/color]",
		"[color=#1f1f1f](portal. Nevertheless, it is still activated.)[/color]",
		"[color=#1f1f1f](Not as strong as I'd hope, but it)[/color]",
		"[color=#1f1f1f](shall suffice.)[/color]",
		"[color=#1f1f1f](The human demands sleepy time.)[/color]",
		"[color=#1f1f1f](So sleepy time I shall.)[/color]",
		"[color=#1f1f1f]Brioche follows Pita to his bedroom to sleep.[/color]",
	])
