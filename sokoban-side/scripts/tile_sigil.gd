extends Node2D
class_name TileSigil

var tile := Vector2i.ZERO

var sigil = Level.Sigil.A
var is_lit := false

func _enter_tree() -> void:
	Level.tile_sigils.append(self)

func _exit_tree() -> void:
	Level.tile_sigils.erase(self)

func light_up() -> void:
	is_lit = true
	set_sprite()
	
func unlight() -> void:
	is_lit = false
	set_sprite()

func set_sprite() -> void:
	if is_lit:
		$Button.region_rect.position.x = 16*4
		$SigilSymbol.region_rect.position.y = 96 + 16
	else:
		$Button.region_rect.position.x = 16*3
		$SigilSymbol.region_rect.position.y = 96
