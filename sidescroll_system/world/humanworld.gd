extends Node2D

@onready var ground: TileMapLayer = $"TileMapLayer-Ground"
@onready var player: Player = $CharacterBody2D

var player_horizontal_bounds := Vector2.ZERO

func _ready() -> void:
	process_physics_priority = 1
	calculate_horizontal_bounds()
	constrain_player()

func _physics_process(_delta: float) -> void:
	constrain_player()
	
func calculate_horizontal_bounds() -> void:
	var ground_rect: Rect2i = ground.get_used_rect()
	if ground_rect.size == Vector2i.ZERO:
		push_error("Ground TileMapLayer has no tiles.")
		return

	var tile_width: int = ground.tile_set.tile_size.x
	var left_edge: int = ground_rect.position.x * tile_width
	var right_edge: int = ground_rect.end.x * tile_width
	var player_offsets: Vector2 = player.get_horizontal_collision()
	player_horizontal_bounds = Vector2(
		left_edge - player_offsets.x,
		right_edge - player_offsets.y
	)
	set_camera_bounds(left_edge, right_edge)

func constrain_player() -> void:
	player.position.x = clampf(player.position.x, player_horizontal_bounds.x, player_horizontal_bounds.y)

func set_camera_bounds(left, right) -> void:
	var camera_node = player.get_node("Camera2D")
	camera_node.limit_left = left
	camera_node.limit_right = right
