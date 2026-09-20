extends Node2D

@onready var dogbowl := $Dogbowl

var _dialogue_manager: DialogueManager
var _is_dialogue_finished = false

func _ready() -> void:
	_dialogue_manager = DialogueManager.get_instance(get_tree())
	if _dialogue_manager == null:
		push_error("No DialogueManager defined for this room.")
		return

	_dialogue_manager.load_messages([
		"[color=#1f1f1f]Alright Brioche, let's see what we got for dinner.[/color]",
		"[color=#1f1f1f]Hmm... some chicken, eggs, rice?[/color]",
		"[color=#1f1f1f]Ohh Bri, what would you like?[/color]",
		"[color=#1f1f1f]I'm feeling some mashed potatoes, hehe.[/color]",
		"[color=#1f1f1f](At last, the hour of nourishment.)[/color]",
		"[color=#1f1f1f](Yes, feed me.)[/color]",
		"[color=#1f1f1f][wave amp=8.0 freq=3.0]...[/wave][/color]",
		"[color=#1f1f1f][wave amp=8.0 freq=3.0]...[/wave][/color]",
		"[color=#1f1f1f][wave amp=8.0 freq=3.0]...[/wave][/color]",
		"[color=#1f1f1f](He is slow. No matter. I am not unreasonable.)[/color]",
		"[color=#1f1f1f](A meal is an acceptable compensation.)[/color]",
		"[color=#1f1f1f]Pita hums to himself.[/color]",
		"[color=#1f1f1f](While the human attends to the)[/color]",
		"[color=#1f1f1f](preparation of my food,)[/color]",
		"[color=#1f1f1f](I shall inspect the surroundings.)[/color]",
	])


func _on_dialogue_trigger_area_body_entered(_body: Node2D) -> void:
	if _is_dialogue_finished:
		return
	
	_dialogue_manager.load_messages([
		"[color=#1f1f1f](There is a paper affixed to the)[/color]",
		"[color=#1f1f1f](refrigerator.)[/color]",
		"[color=#1f1f1f](A crude document, but alas...)[/color]",
		"[color=#1f1f1f](A sigil.)[/color]",
		"[color=#1f1f1f](One of my followers has delivered it.)[/color]",
		"[color=#1f1f1f](How considerate. They have concealed the first)[/color]",
		"[color=#1f1f1f](mark of the rite within the human's dwelling.)[/color]",
		"[color=#1f1f1f](The second stage of my plan...)[/color]",
		"[color=#1f1f1f](...is already underw-)[/color]",
		"[color=#1f1f1f]Who's a hungry boy? Are you hungry, Brioche?[/color]",
		"[color=#1f1f1f]Brioche drools and stares at Pita with a[/color]",
		"[color=#1f1f1f]displeased look.[/color]",
		"[color=#1f1f1f](Fool. Of course I am.)[/color]",
		"[color=#1f1f1f]Pita smiles and pats Brioche's head[/color]",
		"[color=#1f1f1f]as he gets both their meals ready.[/color]",
	])
	await _dialogue_manager.finished
	_is_dialogue_finished = true
	dogbowl.set_bowl_full(true)
	await get_tree().create_timer(1).timeout
	_dialogue_manager.load_messages([
		"[tornado radius=1.0 freq=2.0][color=#1f1f1f](The sigils must be activated...)[/color][/tornado]",
	])
