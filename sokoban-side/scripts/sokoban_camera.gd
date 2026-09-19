extends Camera2D


func _enter_tree() -> void:
	Level.camera = self

func _exit_tree() -> void:
	Level.camera = null
	
func set_to_dark() -> void:
	position.y += 16*9
	
func set_to_light() -> void:
	position.y -= 16*9
