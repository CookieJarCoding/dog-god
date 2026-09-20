extends Node2D

@onready var darkness: ColorRect = $DarknessLayer

var _dialogue_manager: DialogueManager

@export var sokoban_scene: PackedScene

func _ready() -> void:
	_dialogue_manager = DialogueManager.get_instance(get_tree())
	if _dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return
	
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Some time later after Pita is asleep,[/color]",
		"[color=#1f1f1f]Brioche climbs into the attic[/color]",
		"[color=#1f1f1f]to enact the final parts of her plan.[/color]",
		"[color=#1f1f1f]She notes that the attic is especially[/color]",
		"[color=#1f1f1f]dark at night...[/color]",
	])
	await _dialogue_manager.finished
	# Add artificial delay to ensure dialogue box is off screen before fade
	await get_tree().create_timer(1).timeout
	_fade_to_darkness()


func _fade_to_darkness():
	var tween := create_tween()
	tween.tween_property($DarknessLayer, "modulate:a", 1.0, 2.0)
	await tween.finished
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]It's 12:00 AM. Pita is fast asleep.[/color]",
		"[color=#1f1f1f]Brioche however, is getting stronger.[/color]",
		"[color=#1f1f1f]Brioche, now standing on two legs.[/color]",
		"[color=#1f1f1f][tornado radius=1.0 freq=2.0](At last, my plan is almost complete.)[/tornado][/color]",
		"[color=#1f1f1f][tornado radius=1.0 freq=2.0](Reckoning is near.)[/tornado][/color]",
		"[color=#1f1f1f][tornado radius=1.0 freq=2.0](The hour is perfect.)[/tornado][/color]",
		"[color=#1f1f1f][tornado radius=1.0 freq=2.0](The human sleeps soundly.)[/tornado][/color]",
		"[color=#1f1f1f][tornado radius=1.0 freq=2.0](I can work in peace...)[/tornado][/color]",
	])
	await _dialogue_manager.finished
	RoomLoader.start_sokoban(sokoban_scene)
