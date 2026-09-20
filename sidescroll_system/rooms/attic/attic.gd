extends Room

@onready var _player = $Player

func _ready() -> void:
	room_phases = [
		preload("res://sidescroll_system/rooms/attic/phase0/attic_phase0.tscn"),
		preload("res://sidescroll_system/rooms/attic/phase1/attic_phase1.tscn"),
		preload("res://sidescroll_system/rooms/attic/phase2/attic_phase2.tscn")
	]
	super()

func _process(_delta) -> void:
	# Prevent player movement in the "dark" attic sequence
	if RoomLoader.get_active_phase() != 2:
		player.set_physics_process(false)
