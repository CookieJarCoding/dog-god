'''
Tutorial from https://worldeater-dev.itch.io/bittersweet-birthday/devlog/224241/howto-a-simple-dialogue-system-in-godot. I deviated at times for our purposes.
'''


extends CanvasLayer
class_name Dialogue


@onready var dialogue_label: RichTextLabel = $MainContainer/ContentContainer/DialogueLabel
@onready var pause_timer: Timer = $PauseTimer
@onready var pause_calculator: PauseCalculator = $PauseCalculator
@onready var blip: AudioStreamPlayer = $DialogueBlip


var timer: float = 0
var is_timer_running: bool = false
# NOTE: Letters rendered per second.
var message_speed: float = 30.0
var rng = RandomNumberGenerator.new()


'''
Main functions
'''


func _process(delta: float) -> void:
	if OS.is_debug_build() and Input.is_action_just_pressed("debug_m"):
		update_message("[wave amp=7.0 freq=10.0]Hello![/wave]{p=0.5} This is a {p=0.5}piece{p=0.5} of dialogue.")
	
	if timer > (1.0 / message_speed):
		display_next_character()
		timer = 0
	
	if is_timer_running:
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
