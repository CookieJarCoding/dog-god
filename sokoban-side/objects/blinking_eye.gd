extends Node2D

var state := 0
var interval := 10
var d := 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if d >= interval:
		d = 0
	
		if state >= 0:
			$EyeWallSheet1.region_rect.position.x = state*16
			state -= 1
		
		else:
			if randf() >= 0.99:
				state = 4
				
	else:
		d += 1
		 
