'''
Tutorial from https://worldeater-dev.itch.io/bittersweet-birthday/devlog/224241/howto-a-simple-dialogue-system-in-godot. I deviated at times for our purposes.
'''


extends CanvasLayer
class_name Dialogue


const SLIDE_ANIM_DURATION = 0.8

# NOTE: Changing these is only effective in editor, because DialogueManager
# cannot set these values right now.
# WARNING: If we want to dynamically change the size and position of the text box during
# runtime, we'll have to support these values via DialogueManager too.
@export var initial_y_position: float = 200.0
@export var final_y_position: float = 112.0
@export var dialogue_box_size: float = 32.0

@onready var dialogue_label: RichTextLabel = $MainContainer/ContentContainer/DialogueLabel
@onready var pause_timer: Timer = $PauseTimer
@onready var pause_calculator: PauseCalculator = $PauseCalculator
@onready var blip: AudioStreamPlayer = $DialogueBlip


var timer: float = 0
var is_timer_running: bool = false
var is_fully_visible: bool = false
# NOTE: Letters rendered per second.
var message_speed: float = 30.0
var rng = RandomNumberGenerator.new()


signal message_completed


'''
Main functions
'''


func _enter_tree() -> void:
	$MainContainer.position.y = initial_y_position
	slide_up()


func _ready() -> void:
	$MainContainer.set_deferred("size:y", dialogue_box_size)


func _process(delta: float) -> void:
	if timer > (1.0 / message_speed):
		display_next_character()
		timer = 0
	
	if is_timer_running and is_fully_visible:
		timer += delta


func update_message(message: String) -> void:
	dialogue_label.text = pause_calculator.extract_pauses_from_string(message)
	dialogue_label.visible_characters = 0
	start_timer()


func display_next_character() -> void:
	if dialogue_label.visible_characters < dialogue_label.get_parsed_text().length():
		pause_calculator.check_at_position(dialogue_label.visible_characters)
		
		dialogue_label.visible_characters += 1
		# NOTE: Using this implementation, the MINIMUM blip length is set by
		# the length of the .wav file.
		if not blip.playing:
			blip.pitch_scale = rng.randf_range(0.95, 1.08)
			
			# WARNING/TODO: There seems to be a short delay when playing an AudioStream
			# for the first time. To be fixed
			blip.play(0)
	else:
		message_completed.emit()


# NOTE: Animation can be changed if we want. Just make sure to set
# `is_fully_visible" at the end of animation.
func slide_up() -> void:
	var tween = create_tween()
	tween.tween_property($MainContainer, "position:y", final_y_position, SLIDE_ANIM_DURATION).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	is_fully_visible = true


func slide_down() -> void:
	var tween = create_tween()
	tween.tween_property($MainContainer, "position:y", initial_y_position, SLIDE_ANIM_DURATION).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	is_fully_visible = false


'''
Helper functions
'''


func start_timer() -> void:
	is_timer_running = true

func stop_timer() -> void:
	is_timer_running = false

func _on_PauseCalculator_pause_requested(duration: float) -> void:
	stop_timer()
	pause_timer.wait_time = duration
	pause_timer.start()

func _on_PauseTimer_timeout() -> void:
	start_timer()

## TODO
func message_is_fully_visible() -> bool:
	return is_fully_visible
