extends Node2D

var _active_room_path := ""
var _active_phase: int = 0


func enter_room(room: PackedScene) -> void:
	_active_phase = 0
	get_tree().change_scene_to_packed(room)


func start_sokoban(sokoban: PackedScene) -> void:
	if not is_instance_valid(sokoban):
		push_error("Invalid sokoban scene.")
		return

	# Save path to current room for returning from sokoban
	_active_room_path = get_tree().current_scene.scene_file_path

	get_tree().change_scene_to_packed(sokoban)


func finish_sokoban() -> void:
	_active_phase += 1
	get_tree().change_scene_to_file(_active_room_path)


func get_active_phase() -> int:
	return _active_phase
