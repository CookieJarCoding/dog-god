extends Control


func _process(delta: float) -> void:
	if Engine.get_process_frames() % 5 == 0:
		$Label.position.y -= 1
	
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_cancel") or $Label.position.y < -540:
		queue_free()
