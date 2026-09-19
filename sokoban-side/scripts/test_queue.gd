extends LevelData

func _enter_tree() -> void:
	level_name = "Test Level"
	sigil_queue = [
		Level.Sigil.A, 
		Level.Sigil.B,
		Level.Sigil.C,
		Level.Sigil.D,
	]
	
	Level.lvl_data = self

func _exit_tree() -> void:
	Level.lvl_data = null
