extends Node2D

@onready var darkness: ColorRect = $DarknessLayer
@onready var diary: Interactable = $Diary
@onready var choice_ui: Control = $Choice

var _dialogue_manager: DialogueManager
var _is_dialogue_finished = false

func _ready() -> void:
	darkness.show()
	choice_ui.hide()
	_dialogue_manager = DialogueManager.get_instance(get_tree())
	if _dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return

	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Before the last two sigils get activated,[/color]",
		"[color=#1f1f1f]Pita makes his way to the attic, realizing[/color]",
		"[color=#1f1f1f]the source of the noise came from there.[/color]",
		"[color=#1f1f1f]Show yourself![/color]",
		"[color=#1f1f1f]Brioche quickly gets back down on four legs.[/color]",
	])
	await _dialogue_manager.finished
	darkness.hide()


func _on_dialogue_trigger_area_body_entered(body: Node2D) -> void:
	if _is_dialogue_finished:
		return
	var _player_sprite = body.get_node("AnimatedSprite2D") as AnimatedSprite2D
	
	body.set_physics_process(false)
	_player_sprite.play("idle")
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Ah, Brioche... you caused quite a ruckus![/color]",
		"[color=#1f1f1f]What are you doing up here?[/color]",
		"[color=#1f1f1f]Pita grunts as he climbs the remaining[/color]",
		"[color=#1f1f1f]steps of the ladder into his attic.[/color]",
		"[color=#1f1f1f]Pita kneels to pet Brioche,[/color]",
		"[color=#1f1f1f]which Brioche feels indifferent about.[/color]",
		"[color=#1f1f1f]He looks up, and notices a special notebook.[/color]",
		"[color=#1f1f1f]Is that my diary, boy?[/color]",
	])
	await _dialogue_manager.finished
	_player_sprite.flip_h = true

	# Delay for dramatic effect
	await get_tree().create_timer(1).timeout

	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Pita looks at the diary,[/color]",
		"[color=#1f1f1f]nostalgia starting to flood him.[/color]",
		"[color=#1f1f1f]Oh my... This unlocks a lot of memories for me...[/color]",
		"[color=#1f1f1f]Ahh.. Remember when I adopted you, Brioche?[/color]",
		"[color=#1f1f1f]I used to be able to jog still...hehe.[/color]",
		"[color=#1f1f1f]Say boy, why don't you look at this with me...?[/color]",
		"[color=#1f1f1f]I remember when you used to be a puppy...[/color]",
	])
	await _dialogue_manager.finished
	body.set_physics_process(true)
	_is_dialogue_finished = true
	diary.enable_diary()
	choice_ui.show()
