extends Interactable

static var has_finished_tutorial = false

@export var is_full := true

var is_dialogue_playing = false

@onready var _sprite = $BaseSprite

func _ready() -> void:
	lit_sprite = $GlowSprite
	_set_bowl_full(is_full)


func interact() -> void:
	if not has_finished_tutorial:
		await _trigger_intro_dialogue()
		has_finished_tutorial = true
	else:
		# Switch to eldritch world
		pass


func _trigger_intro_dialogue() -> void:
	var dialogue_manager := get_dialogue_manager()
	if dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return

	dialogue_manager.load_messages([
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
	await dialogue_manager.finished


func _set_bowl_full(full: bool) -> void:
	_sprite.frame = 0 if full else 2
	lit_sprite.frame = 1 if full else 3
