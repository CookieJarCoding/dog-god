extends Room

func _ready() -> void:
	room_phases = [
		preload("res://sidescroll_system/rooms/attic/phase0/attic_phase0.tscn"),
		preload("res://sidescroll_system/rooms/attic/phase1/attic_phase1.tscn"),
		preload("res://sidescroll_system/rooms/attic/phase2/attic_phase2.tscn")	
	]
	super()
