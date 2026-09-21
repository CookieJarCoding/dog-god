extends Node2D

var _dialogue_manager: DialogueManager

@export var sokoban_scene: PackedScene

func _ready() -> void:
	_dialogue_manager = DialogueManager.get_instance(get_tree())
	if _dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return
	
	$BooksDrop.play()
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Brioche accidentally knocks over a few[/color]",
		"[color=#1f1f1f]books, making a loud noise.[/color]",
		"[color=#1f1f1f]She freezes as she hears some[/color]",
		"[color=#1f1f1f]shuffling downstairs.[/color]",
		"[color=#1f1f1f](Curses. I've been caught.)[/color]",
		"[color=#1f1f1f]Hello? Who goes there...[/color]",
		"[color=#1f1f1f]Brioche stays still, until she hears Pita go down[/color]",
		"[color=#1f1f1f]the stairs.[/color]",
		"[color=#1f1f1f][tornado radius=1.0 freq=2.0](I must continue.)[/tornado][/color]",
	])
	await _dialogue_manager.finished
	RoomLoader.start_sokoban(sokoban_scene)
