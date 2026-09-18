'''
Tutorial from https://worldeater-dev.itch.io/bittersweet-birthday/devlog/224241/howto-a-simple-dialogue-system-in-godot. I deviated at times for our purposes.
'''

extends Node
class_name DialogueManager

const DIALOGUE_SCENE := preload("res://dialogue_system/dialogue_hud.tscn")

# tween here

signal message_requested
signal message_completed
signal finished

var messages := []
var active_dialogue_index := 0
var is_active := false
var current_dialogue_instance: Dialogue



func _process(_delta: float) -> void:
	pass


# NOTE: Why the position parameter?
func show_messages(message_list: Array, _position: Vector2) -> void:
	if is_active:
		return
	
	messages = message_list
	active_dialogue_index = 0
	
	var dialogue: Dialogue = DIALOGUE_SCENE.instance()
	dialogue.connect("message_completed", on_message_completed)
	
	# NOTE: Why as child of the root in the tutorial? I opted to add it as sibling instead.
	add_sibling(dialogue)
	
	current_dialogue_instance = dialogue
	
	show_current()


func show_current() -> void:
	emit_signal("message_requested")
	var message: String = messages[active_dialogue_index]
	current_dialogue_instance.update_message(message)


func on_message_completed() -> void:
	pass
