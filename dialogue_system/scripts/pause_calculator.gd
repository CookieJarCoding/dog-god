'''
From the tutorial:
	The "_pauses" array will hold a reference to each found pause inside the string, alongside its duration and position on the message
	The "_find_pauses()" method will actually find these pause tags inside the source_string string, remove them and register them on the array
	The "_extract_tags()" method will clean all of our custom tags, and return the string that we must pass to the bbcode_text property on the dialogue.
'''

extends Node
class_name PauseCalculator

signal pause_requested(duration)


## NOTE: Detects "{p=%f}" patterns in strings
const PAUSE_REGEX_PATTERN := "({p=\\d([.]\\d+)?[}])"
var regex = RegEx.new()
var pauses := []


func _ready() -> void:
	regex.compile(PAUSE_REGEX_PATTERN)


# I'm just following the tutorial, but this could probably be condensed.
func extract_pauses_from_string(source_string: String) -> String:
	pauses = []
	find_pauses(source_string)
	return extract_tags(source_string)


func find_pauses(source_string: String) -> void:
	var found_pauses = regex.search_all(source_string)
	for result in found_pauses:
		# NOTE: A PAUSE tag is of the form "{p=%f}" where %f is some floating point number.
		var tag_string: String = result.get_string()
		var tag_position: int = adjust_tag_position(result.get_start(), source_string)
		
		if OS.is_debug_build():
			print(tag_string, tag_position)
		
		var pause = Pause.new(tag_position, tag_string)
		pauses.append(pause)


# NOTE: Because tags add characters to the string, they 'offset' the correct position
# of the pauses. We have to subtract this total offset that add up from all previous tags.
func adjust_tag_position(pos: int, source_string: String) -> int:
	var any_tag_regex = RegEx.new()
	any_tag_regex.compile("({(.*?)})")
	
	## Account for previous tags
	
	var new_pos := pos
	var left_of_pos := source_string.left(pos)
	var all_previous_tags := any_tag_regex.search_all(left_of_pos)
	
	for tag in all_previous_tags:
		new_pos -= tag.get_string().length()
	
	## Account for previous BBCodes
	# NOTE: regex might not be 100% accurate apparently?
	
	var bbcode_i_regex := RegEx.new()
	var bbcode_e_regex := RegEx.new()
	
	bbcode_i_regex.compile("\\[(?!\\/)(.*?)\\]")
	bbcode_e_regex.compile("\\[\\/(.*?)\\]")
	
	var all_prev_start_bbcodes := bbcode_i_regex.search_all(left_of_pos)
	for tag in all_prev_start_bbcodes:
		new_pos -= tag.get_string().length()
	
	var all_prev_end_bbcodes := bbcode_e_regex.search_all(left_of_pos)
	for tag in all_prev_end_bbcodes:
		new_pos -= tag.get_string().length()
	
	return new_pos


# NOTE: ANY tag is of the form "{tag=value}"
func extract_tags(source_string: String) -> String:
	var any_tag_regex = RegEx.new()
	any_tag_regex.compile("({(.*?)})")
	
	# Removes everything inside {} (including the braces) 
	return any_tag_regex.sub(source_string, "", true)


func check_at_position(pos: int) -> void:
	for pause in pauses:
		# next line is unnecessary but I like having autocomplete
		if pause is Pause:
			if pause.pause_pos == pos:
				emit_signal("pause_requested", pause.duration)
