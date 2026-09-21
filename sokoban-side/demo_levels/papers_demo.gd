extends Node2D

var sigil_queue = [
	Level.Sigil.B,
	]

func _enter_tree() -> void:
	Level.sigil_queue = sigil_queue
