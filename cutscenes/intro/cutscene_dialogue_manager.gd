extends DialogueManager

const FADE_IN_OUT_TIME := 1.0

## Overrides
func _ready() -> void:
	current_dialogue_instance = get_parent()
	current_dialogue_instance.message_completed.connect(on_message_completed)
	
	await current_dialogue_instance.ready
	load_messages([
		"AND THERE WAS PLACEHOLDER TEXT.",
		"AND THEN THERE WAS MORE."
	])

## Overrides
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		# NOTE: We *could* make it so that messages can only be moved forward iff
		# the message has been fully rendered
		if is_active and current_dialogue_instance.message_is_fully_visible():
			# NOTE: This waits until the dialogue is done.
			await message_completed
			if active_dialogue_index < messages.size() - 1:
				transition_text()
			else:
				hide()


## NOTE/WARNING/TODO: THIS IS REALLY BAD AND NEEDS TO BE REFACTORED BUT IT WORKS
func transition_text() -> void:
	PaletteSwapper.tween_to_brightness(-1, FADE_IN_OUT_TIME)
	await PaletteSwapper.tween_done 
	current_dialogue_instance.slide_down()
	current_dialogue_instance.display_next_image()
	
	active_dialogue_index += 1
	show_current_message()
	
	PaletteSwapper.tween_to_brightness(0, FADE_IN_OUT_TIME)
	await PaletteSwapper.tween_done 
	current_dialogue_instance.slide_up()


## Overrides
func load_messages(message_list: Array) -> void:
	if is_active or message_list.is_empty():
		return
	is_active = true
	
	messages = message_list
	active_dialogue_index = 0
	
	show_current_message()


func hide() -> void:
	super()
	PaletteSwapper.tween_to_brightness(-1, FADE_IN_OUT_TIME)
