'''
Tutorial from https://worldeater-dev.itch.io/bittersweet-birthday/devlog/224241/howto-a-simple-dialogue-system-in-godot. I deviated at times for our purposes.
'''

extends Node
class_name DialogueManager

const DIALOGUE_SCENE := preload("res://dialogue_system/dialogue_hud.tscn")

# WARNING: Signals currently unused
signal message_requested
signal message_completed
signal finished

var messages := []
var active_dialogue_index := 0
var is_active := false
var is_hiding := false
var current_dialogue_instance: Dialogue

@export var blip_sfx: AudioStream



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		# NOTE: We *could* make it so that messages can only be moved forward iff
		# the message has been fully rendered
		if is_active and current_dialogue_instance.message_is_fully_visible():
			if active_dialogue_index < messages.size() - 1:
				active_dialogue_index += 1
				show_current_message()
			else:
				hide()


# Static getter to make DialogueManager available from any node
static func get_instance(tree: SceneTree) -> DialogueManager:
	return tree.get_first_node_in_group('dialogue_manager') as DialogueManager


# NOTE: Opted to call this 'load_' instead of 'show_messages'
# NOTE: load_messages() WILL immediately show the first dialogue with this implementation.
func load_messages(message_list: Array) -> void:
	if is_active or message_list.is_empty():
		return
	is_active = true
	
	messages = message_list
	active_dialogue_index = 0
	
	var dialogue: Dialogue = DIALOGUE_SCENE.instantiate()
	# NOTE: This might be a little confusing, but basically
	# Dialogue.message_completed --TRIGGERS--> DialogueManager.on_message_completed()
	# on_message_completed() --EMITS--> DialogueManager.message_completed
	# The last signal can then be used to, say, show a button indicator for when to move dialogue.
	dialogue.message_completed.connect(on_message_completed)
	
	# NOTE: I opted to add dialogue HUD as sibling instead.
	add_sibling.call_deferred(dialogue)
	
	current_dialogue_instance = dialogue
	if blip_sfx:
		current_dialogue_instance.set_blip_sfx(blip_sfx)
	
	# WARNING: This is apparently necessary to make this work. Without it,
	# show_current_messages() -> dialogue.update_message() internally does something 
	# that requires the scene to be ready.
	await dialogue.ready
	show_current_message()


func show_current_message() -> void:
	message_requested.emit()
	var message: String = messages[active_dialogue_index]
	current_dialogue_instance.update_message(message)


func hide() -> void:
	if is_hiding:
		return
	
	is_hiding = true
	# Nice, this is being responsible with signals LOL
	current_dialogue_instance.disconnect("message_completed", on_message_completed)
	current_dialogue_instance.slide_down()
	await current_dialogue_instance.dialogue_ended
	current_dialogue_instance = null
	is_active = false
	is_hiding = false
	finished.emit()


func on_message_completed() -> void:
	message_completed.emit()
