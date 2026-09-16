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

	print(Level.sigil_queue)

	edit_sprite(direction)
	
	if can_move(direction):
		move(direction)

func move(direction: Vector2i) -> void:
	var sigil := Level.get_sigil_at_tile(tile + direction)
	
	if sigil != null: # HANDLES SIGIL LOGIC
		if sigil.is_lit:
			sigil.unlight()
		
		elif len(Level.sigil_queue) != 0:
			if sigil.sigil == Level.sigil_queue[0]:
				sigil.light_up()
				Level.pop_first_sigil()
			else:
				return

	slide(direction)

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
