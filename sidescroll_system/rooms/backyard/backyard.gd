extends Room

func _ready() -> void:
	room_phases = [
		preload("res://sidescroll_system/rooms/backyard/phase0/backyard_phase0.tscn"),
		preload("res://sidescroll_system/rooms/backyard/phase1/backyard_phase1.tscn"),	
	]
	super()
	PaletteSwapper.set_palette(PaletteList.BACKYARD)
