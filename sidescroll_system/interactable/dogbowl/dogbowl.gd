extends Interactable

static var has_finished_tutorial = false

@export var is_full := true
# For each Dogbowl instance, assign correct sokoban scene in the Inspector
@export var sokoban_scene: PackedScene

@onready var _sprite = $BaseSprite

func _ready() -> void:
	lit_sprite = $GlowSprite
	set_bowl_full(is_full)


func interact() -> void:
	var dialogue_manager := DialogueManager.get_instance(get_tree())
	if dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return

	# Block interactions when dialogue is playing
	if dialogue_manager.is_active:
		return

	if is_full:
		if not has_finished_tutorial:
			await _trigger_intro_dialogue(dialogue_manager)
			has_finished_tutorial = true
		else:
			# Switch to eldritch world
			await _fade_to_darkness()
			RoomLoader.start_sokoban(sokoban_scene)
	else:
		if RoomLoader.get_active_phase() != 0:
			dialogue_manager.load_messages([
				"[color=#1f1f1f](My work is done here.)[/color]",
			])
		else:
			dialogue_manager.load_messages([
				"[color=#1f1f1f](It is not the right time yet.)[/color]",
			])


func _trigger_intro_dialogue(dialogue: DialogueManager) -> void:
	dialogue.load_messages([
		"[color=#1f1f1f](My owner has spoiled me with fresh meat)[/color]",
		"[color=#1f1f1f](in my food bowl.)[/color]",
		"[color=#1f1f1f](For years, I have endured this disrespect.)[/color]",
		"[color=#1f1f1f](This undignified vessel for a god like me,)[/color]",
		"[color=#1f1f1f](but the offerings...)[/color]",
		"[color=#1f1f1f](are of the highest quality.)[/color]",
		"[color=#1f1f1f](Hence, I endure.)[/color]",
		"[color=#1f1f1f]Brioche's stomach growls.[/color]",
		"[color=#1f1f1f](...I am hungry.)[/color]",
		"[color=#1f1f1f](I suppose, there is more to this vessel)[/color]",
		"[color=#1f1f1f](than nourishment.)[/color]",
		"[color=#1f1f1f](...)[/color]",
		"[color=#1f1f1f](It's hollow.)[/color]",
		"[color=#1f1f1f](It's deep enough to contain an entire world...)[/color]",
		"[color=#1f1f1f](and with the proper rites,)[/color]",
		"[tornado radius=1.0 freq=2.0][color=#1f1f1f](perhaps a passage into one.)[/color][/tornado]"
	])
	await dialogue.finished


func _fade_to_darkness() -> void:
	var tween := create_tween()
	tween.tween_property($DarknessLayer, "modulate:a", 1.0, 1.0)
	await tween.finished


func set_bowl_full(full: bool) -> void:
	is_full = full
	_sprite.frame = 0 if full else 2
	lit_sprite.frame = 1 if full else 3
