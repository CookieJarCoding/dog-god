extends Node2D

@onready var darkness: ColorRect = $DarknessLayer

var _dialogue_manager: DialogueManager
var _is_dialogue1_finished = false
var _is_dialogue2_finished = false

func _ready() -> void:
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


func _on_dialogue_1_trigger_area_body_entered(body: Node2D) -> void:
	if _is_dialogue1_finished:
		return
	
	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Ah, Brioche... you caused quite a ruckus![/color]",
		"[color=#1f1f1f]What are you doing up here?[/color]",
		"[color=#1f1f1f]Pita grunts as he climbs the remaining[/color]",
		"[color=#1f1f1f]steps of the ladder into his attic.[/color]",
		"[color=#1f1f1f]Pita kneels to pet Brioche,[/color]",
		"[color=#1f1f1f]which Brioche feels indifferent about.[/color]",
		"[color=#1f1f1f]He looks up, and notices an open notebook.[/color]",
		"[color=#1f1f1f]Is that my diary, boy?[/color]",
	])
	await _dialogue_manager.finished
	_is_dialogue1_finished = true


func _on_dialogue_2_trigger_area_body_entered(body: Node2D) -> void:
	if _is_dialogue2_finished:
		return

	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Pita picks up the diary,[/color]",
		"[color=#1f1f1f]nostalgia starting to flood him[/color]",
		"[color=#1f1f1f]Oh my... This unlocks a lot of memories for me...[/color]",
		"[color=#1f1f1f]Ahh.. Remember when I adopted you, Brioche?[/color]",
		"[color=#1f1f1f]I used to be able to jog still...hehe.[/color]",
		"[color=#1f1f1f]Say boy, why don't you look at this with me...?[/color]",
		"[color=#1f1f1f]I remember when you used to be a puppy...[/color]",
	])
	await _dialogue_manager.finished
	_is_dialogue2_finished = true
