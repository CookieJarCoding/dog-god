extends Node2D
class_name Moveable

# Moveable: class used for things we want to move
# We'll only need the player for now tho

var tile := Vector2i.ZERO

# var undo_stack : Array[Vector2i] (in case we ever want to undo)

func _ready() -> void:
	tile = (Vector2i(position) - Level.TILE_SIZE / 2) / 16
	position = tile * Vector2i(16, 16) + Level.TILE_SIZE / 2

func _enter_tree() -> void:
	Level.moveables.append(self)
	

func _exit_tree() -> void:
	Level.moveables.erase(self)

func can_move(direction: Vector2i) -> bool:
	return Level.get_tile_type(Vector2i(tile) + direction) == 0
	
func move(direction: Vector2i) -> void:
	if can_move(direction):
		slide(direction)

func slide(direction: Vector2i) -> void:
	tile += direction
	var target_pos := Vector2(tile) * Vector2(16, 16) + Vector2(Level.TILE_SIZE) / 2
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", target_pos, 0.1)
