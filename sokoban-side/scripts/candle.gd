extends Interactable
class_name Candle
	
func on_pickup() -> void:
	Level.flip()
