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
		"[color=#1f1f1f]Some time later after Peta is asleep,[/color]",
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
		"[color=#1f1f1f]It's 12:00 AM. Peta is fast asleep.[/color]",
		"[color=#1f1f1f]Brioche however, is getting stronger.[/color]",
		"[color=#1f1f1f]Brioche, now standing on 2 legs.[/color]",
		"[color=#1f1f1f](At last, my plan is almost complete.)[/color]",
		"[color=#1f1f1f](Reckoning is near.)[/color]",
		"[color=#1f1f1f](The hour is perfect.)[/color]",
		"[color=#1f1f1f](The human sleeps soundly.)[/color]",
		"[color=#1f1f1f](I can work in peace...)[/color]",
	])
	await _dialogue_manager.finished
	RoomLoader.start_sokoban(sokoban_scene)
