extends Interactable
class_name SigilPaper

var sigil := Level.Sigil.A
var bob_offset := randf_range(0.0, 10000.0)

func on_pickup() -> void:
	if is_active and len(Level.sigil_queue.queue) < Level.QUEUE_LIMIT:
		Level.add_sigil_at_front(sigil)
		deactivate()
		
func deactivate() -> void:
	is_active = false
	visible = false
	
func _process(delta: float) -> void:
	
	position.y = (tile.y * 16 + 8) + sin((Time.get_ticks_msec() + bob_offset)/ 1000.0 * 1) * 1.0
	pass
