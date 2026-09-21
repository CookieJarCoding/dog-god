extends Label

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	text = Level.lvl_data.level_name
