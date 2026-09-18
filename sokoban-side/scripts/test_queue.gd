extends Node2D

var sigil_queue = [
	Level.Sigil.A, 
	Level.Sigil.A,
	]

func _enter_tree() -> void:
	Level.sigil_queue = sigil_queue
