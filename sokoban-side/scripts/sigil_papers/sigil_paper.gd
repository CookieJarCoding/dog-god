extends Interactable
class_name SigilPaper

var sigil := Level.Sigil.A
var bob_offset := randf_range(0.0, 10000.0)
var is_block := false

func _enter_tree() -> void:
	Level.interactables.append(self)
	Level.sigil_papers.append(self)

func _exit_tree() -> void:
	Level.sigil_papers.erase(self)
	Level.interactables.erase(self)
	
func on_pickup() -> void:
	if is_active and len(Level.sigil_queue.queue) < Level.QUEUE_LIMIT:
		Level.add_sigil_at_front(sigil)
		deactivate()
		
func deactivate() -> void:
	is_active = false
	visible = false
	
func flip_activity() -> void:
	if visible:
		is_active = !is_active
		if is_active:
			is_block = false
			$Button.region_rect.position.x = 16*5
			$Button.region_rect.position.y = 16*3
			$SigilSymbol.region_rect.position.y = 16*6
		else:
			is_block = true
			$Button.region_rect.position.x = 16*6
			$Button.region_rect.position.y = 16*4
			$SigilSymbol.region_rect.position.y = 16*7
	
func _process(delta: float) -> void:
	if is_active:
		position.y = (tile.y * 16 + 8) + sin((Time.get_ticks_msec() + bob_offset)/ 1000.0 * 1) * 1.0
	pass
	
func set_pos(pos: Vector2i) -> void:
	tile = pos
	position = tile * Vector2i(16, 16) + Level.TILE_SIZE / 2
