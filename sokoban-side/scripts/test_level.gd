extends Node2D

var sigil_queue = [
	Level.Sigil.A, 
	Level.Sigil.B, 
	Level.Sigil.C, 
	Level.Sigil.D, 
	]

func _enter_tree() -> void:
	Level.sigil_queue = sigil_queue
