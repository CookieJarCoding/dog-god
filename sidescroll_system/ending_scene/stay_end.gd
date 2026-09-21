extends Node2D

var dialogue_manager: DialogueManager


func _ready() -> void:
	$StayEndMusicPlayer.play()
	PaletteSwapper.set_brightness(0.0)

	dialogue_manager = DialogueManager.new()
	add_child(dialogue_manager)
	load_dialogue()


func load_dialogue() -> void:
	dialogue_manager.load_messages([
		"[color=#1F1F1F]Brioche stands between her owner,[/color]",
		"[color=#1F1F1F]and the last two sigils across the room.[/color]",
		"[color=#1F1F1F]Curious, and sentimental as she begins to[/color]",
		"[color=#1F1F1F]remember how the last ten years were[/color]",
		"[color=#1F1F1F]for her and her owner.[/color]",
		"[color=#1F1F1F]Just the two of them, together.[/color]"
	])
	await dialogue_manager.finished
	# Delay for dramatic effect
	await get_tree().create_timer(1.0).timeout

	dialogue_manager.load_messages([
		"[color=#1F1F1F]Brioche inserts herself in her owner's arms,[/color]",
		"[color=#1F1F1F]the most normal dog thing she's done in a while.[/color]",
		"[color=#1F1F1F]Pita pets her head and stands up to guide[/color]",
		"[color=#1F1F1F]the both of them back to the bedroom.[/color]",
		"[color=#1F1F1F]Pita climbs into bed and pats the spot next[/color]",
		"[color=#1F1F1F]to him, calling for Brioche to curl up beside him.[/color]",
		"[color=#1F1F1F]Brioche obliges.[/color]"
	])
	await dialogue_manager.finished
	# Delay for dramatic effect
	await get_tree().create_timer(1.0).timeout

	dialogue_manager.load_messages([
		"[color=#1F1F1F]Ah... this brings back memories[/color]",
		"[color=#1F1F1F]Pita says, as he begins reading his diary[/color]",
		"[color=#1F1F1F]out loud to Brioche.[/color]",
		"[color=#1F1F1F]Brioche, soothed by her owner's voice,[/color]",
		"[color=#1F1F1F]begins to fall asleep.[/color]"
	])
	await dialogue_manager.finished
	# Delay for dramatic effect
	await get_tree().create_timer(1.0).timeout

	dialogue_manager.load_messages([
		"[color=#1F1F1F](This man has taken care of me for 10 years.)[/color]",
		"[color=#1F1F1F](Full of love, full of joy.)[/color]",
		"[color=#1F1F1F](He isn't like any other human I have seen.)[/color]",
		"[color=#1F1F1F](This one is filled with kindness, and sincerity.)[/color]",
		"[color=#1F1F1F]Maybe...humanity's time can wait.[/color]",
		"[color=#1F1F1F]For now, she will just be Pita's best friend.[/color]"
	])
	await dialogue_manager.finished
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
