'''
A custom data structure for storing and handling dialogue pauses.
Based on the tutorial in PauseCalculator.
'''

class_name Pause

# Number dot Number
const FLOAT_PATTERN := "\\d+\\.\\d+"
var pause_pos: int
var duration: float

func _init(position: int, tag_string: String) -> void:
	var regex := RegEx.new()
	regex.compile(FLOAT_PATTERN)
	
	duration = float(regex.search(tag_string).get_string())
	pause_pos = int(clamp(position - 1, 0, abs(position)))
