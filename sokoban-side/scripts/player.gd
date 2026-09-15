extends Moveable
class_name Player

var direction := Vector2i.UP

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		direction = (Vector2i.UP)
	elif event.is_action_pressed("down"):
		direction = (Vector2i.DOWN)
	elif event.is_action_pressed("left"):
		direction = (Vector2i.LEFT)
	elif event.is_action_pressed("right"):
		direction = (Vector2i.RIGHT)
	else:
		return

	edit_sprite(direction)
	
	if can_move(direction):
		move(direction)

func edit_sprite(direction: Vector2i) -> void:
	var sprite_region := Rect2(0, 0, 16, 16)
	match direction:
		Vector2i.UP:
			sprite_region = Rect2(0, 0, 16, 16)
		Vector2i.RIGHT:
			sprite_region = Rect2(16, 0, 16, 16)
		Vector2i.LEFT:
			sprite_region = Rect2(0, 16, 16, 16)
		Vector2i.DOWN:
			sprite_region = Rect2(16, 16, 16, 16)
					
	$Sprite2D.region_rect = sprite_region
