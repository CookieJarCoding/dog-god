extends Interactable
class_name SigilPaper

var sigil := Level.Sigil.A

func on_pickup() -> void:
	if is_active and len(Level.sigil_queue) < 10:
		Level.add_sigil_at_front(sigil)
		deactivate()
		
func deactivate() -> void:
	is_active = false
	visible = false
	
