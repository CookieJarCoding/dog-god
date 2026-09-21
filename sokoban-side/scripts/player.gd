extends Moveable
class_name Player

var direction := Vector2i.UP

var step := true # for dog walking animation

func _enter_tree() -> void:
	Level.player = self

func _exit_tree() -> void:
	Level.player = null

func _input(event: InputEvent) -> void:
	if not Level.if_win():
		if event.is_action_pressed("up"):
			direction = (Vector2i.UP)
		elif event.is_action_pressed("down"):
			direction = (Vector2i.DOWN)
		elif event.is_action_pressed("left"):
			direction = (Vector2i.LEFT)
		elif event.is_action_pressed("right"):
			direction = (Vector2i.RIGHT)
		elif event.is_action_pressed("Q"):
			Level.restart()
			return
		else:
			return
	else:
		return

	edit_sprite(direction)
	
	if can_move(direction):
		move(direction)

func move(direction: Vector2i) -> void:
	var sigil := Level.get_sigil_at_tile(tile + direction)
	var pickup := Level.get_interactable_at_tile(tile + direction)
	
	if sigil != null: # HANDLES SIGIL LOGIC
		if sigil.is_lit:
			sigil.unlight()
		
		elif len(Level.sigil_queue.queue) != 0:
			if sigil.sigil == Level.get_first_at_queue():
				MusicHandler.sigil_collect.play()
				sigil.light_up()
				Level.pop_first_sigil()
				
			else:
				return
	
	elif pickup != null:
		if pickup is SigilPaper and pickup.is_active:
			MusicHandler.sigil_paper.play()
		pickup.on_pickup()
	
	slide(direction)
	
	if Level.if_win():
		await Level.start_next_level()

func edit_sprite(direction: Vector2i) -> void:
	var x = 0
	if step:
		x = 16
	
	step = not step
		
	var sprite_region : Rect2
	match direction:
		Vector2i.UP:
			sprite_region = Rect2(x, 32, 16, 16)
		Vector2i.RIGHT:
			sprite_region = Rect2(x, 16, 16, 16)
		Vector2i.LEFT:
			sprite_region = Rect2(x, 48, 16, 16)
		Vector2i.DOWN:
			sprite_region = Rect2(x, 0, 16, 16)
					
	$Sprite2D.region_rect = sprite_region
