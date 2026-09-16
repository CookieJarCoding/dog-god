extends Node2D

@onready var ground: TileMapLayer = $"TileMapLayer-Ground"
@onready var player: Player = $CharacterBody2D

var tile_size = 16

func _ready() -> void:
	var ground_rect: Rect2i = ground.get_used_rect()
	if ground_rect.size == Vector2i.ZERO:
		push_error("Ground TileMapLayer has no tiles.")
		return
	var world_bounds := Rect2(
		ground_rect.position,  ground_rect.size)	
