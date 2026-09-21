extends Room

func _ready() -> void:
	room_phases = [
		preload("res://sidescroll_system/rooms/kitchen/phase0/kitchen_phase0.tscn"),
		preload("res://sidescroll_system/rooms/kitchen/phase1/kitchen_phase1.tscn"),	
	]
	super()
	PaletteSwapper.set_palette(PaletteList.KITCHEN)
