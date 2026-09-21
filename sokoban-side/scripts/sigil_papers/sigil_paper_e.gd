extends SigilPaper

func _ready() -> void:
	sigil = Level.Sigil.E
	
	tile = (Vector2i(position) - Level.TILE_SIZE / 2) / 16
	position = tile * Vector2i(16, 16) + Level.TILE_SIZE / 2
