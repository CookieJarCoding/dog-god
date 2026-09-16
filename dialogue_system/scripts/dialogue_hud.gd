extends CanvasLayer
class_name Dialogue

'''
Tutorial from https://worldeater-dev.itch.io/bittersweet-birthday/devlog/224241/howto-a-simple-dialogue-system-in-godot
'''

@onready var dialogue_label: RichTextLabel = $MainContainer/ContentContainer/DialogueLabel
# NOTE: Currently unused
@onready var pause_timer: Timer = $PauseTimer


var timer: float = 0
var is_timer_running: bool = false
# NOTE: Letters rendered per second.
var message_speed: float = 10.0


func _ready() -> void:
	update_message("Hello! This is a piece of dialogue.")


func _process(delta: float) -> void:
	if timer > (1.0 / message_speed):
		display_next_character()
		timer = 0
	
	if is_timer_running:
		timer += delta


func update_message(message: String) -> void:
	dialogue_label.text = message
	dialogue_label.visible_characters = 0
	start_timer()


func start_timer() -> void:
	is_timer_running = true


func display_next_character() -> void:
	if dialogue_label.visible_characters < dialogue_label.text.length():
		dialogue_label.visible_characters += 1
