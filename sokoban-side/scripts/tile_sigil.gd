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
	
func unlight() -> void:
	is_lit = false
	
func set_sprite() -> void:
	pass # Will do this if theres actual sigil sprits im too lazy bleh
