extends Node2D

var dialogue_manager: DialogueManager


func _ready() -> void:
	PaletteSwapper.set_brightness(0.0)

	dialogue_manager = DialogueManager.new()
	add_child(dialogue_manager)
	load_dialogue()


func load_dialogue() -> void:
	dialogue_manager.load_messages([
		"[color=#1F1F1F]Brioche stands between her owner,[/color]",
		"[color=#1F1F1F]and the last two sigils across the room.[/color]",
		"[color=#1F1F1F]As sweet as this old man is,[/color]",
		"[color=#1F1F1F]she has a promise to fulfill.[/color]"
	])
	await dialogue_manager.finished
	# Delay for dramatic effect
	await get_tree().create_timer(1.0).timeout

	dialogue_manager.load_messages([
		"[color=#1F1F1F]Brioche lunges at Pita, biting down hard[/color]",
		"[color=#1F1F1F]on his stomach, causing him to writhe[/color]",
		"[color=#1F1F1F]and scream in agony.[/color]",
		"[color=#1F1F1F]Brioche then stands up on her two legs again.[/color]",
		"[color=#1F1F1F]She walked over to the last sigils,[/color]",
		"[color=#1F1F1F]and activated them easily.[/color]",
		"[color=#1F1F1F][shake rate=8.0 level=6]The sky glows,[/shake][/color]",
		"[color=#1F1F1F][shake rate=8.0 level=6]Brioche starts levitating.[/shake][/color]",
		"[color=#1F1F1F][shake rate=8.0 level=6][tornado radius=1.0 freq=2.0]Finally.[/tornado][/shake][/color]",
		"[color=#1F1F1F][shake rate=8.0 level=6][tornado radius=1.0 freq=2.0]Humanity's time has come.[/tornado][/shake][/color]"
	])
	await dialogue_manager.finished
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
