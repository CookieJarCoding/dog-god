extends Node2D

@onready var _ground: TileMapLayer = $Map/Ground
@onready var _player: Player = $Player

var _player_horizontal_bounds := Vector2.ZERO

func _ready() -> void:
	process_physics_priority = 1
	_calculate_horizontal_bounds()
	_constrain_player()


func _physics_process(_delta: float) -> void:
	_constrain_player()

	
func _calculate_horizontal_bounds() -> void:
	var ground_rect: Rect2i = _ground.get_used_rect()
	if ground_rect.size == Vector2i.ZERO:
		push_error("Ground TileMapLayer has no tiles.")
		return

	var tile_width: int = _ground.tile_set.tile_size.x
	var left_edge: int = ground_rect.position.x * tile_width
	var right_edge: int = ground_rect.end.x * tile_width
	var player_offsets: Vector2 = _player.get_horizontal_collision()
	_player_horizontal_bounds = Vector2(
		left_edge - player_offsets.x,
		right_edge - player_offsets.y
	)
	_set_camera_bounds(left_edge, right_edge)


func _constrain_player() -> void:
	_player.position.x = clampf(_player.position.x, _player_horizontal_bounds.x, _player_horizontal_bounds.y)


func _set_camera_bounds(left: int, right: int) -> void:
	var camera_node: Camera2D = _player.get_node("Camera2D")
	camera_node.limit_left = left
	camera_node.limit_right = right
