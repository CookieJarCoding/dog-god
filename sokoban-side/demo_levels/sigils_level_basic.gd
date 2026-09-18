extends Node2D

var sigil_queue = [
	Level.Sigil.A, 
	Level.Sigil.B, 
	Level.Sigil.C, 
	Level.Sigil.B, 
	Level.Sigil.D, 
	Level.Sigil.C, 
	]

func _enter_tree() -> void:
	Level.sigil_queue = sigil_queue
