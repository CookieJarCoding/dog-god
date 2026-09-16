extends Node2D

var SIGIL_A = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_a.tscn")
var SIGIL_B = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_b.tscn")
var SIGIL_C = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_c.tscn")
var SIGIL_D = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_d.tscn")
var SIGIL_E = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_e.tscn")
var SIGIL_F = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_f.tscn")

var queue = []

func _ready() -> void:
	print(Level.sigil_queue)
	
	display_queue(Level.sigil_queue)

func _process(delta: float) -> void:
	display_queue(Level.sigil_queue)

func display_queue(sigil_queue) -> void:
	for q in queue:
		q.queue_free()
		
	queue = []
	
	var n = 0
	for sq in sigil_queue:
		var to_append : Node2D
		
		match sq:
			Level.Sigil.A:
				to_append = SIGIL_A.instantiate()
			Level.Sigil.B:
				to_append = SIGIL_B.instantiate()
			Level.Sigil.C:
				to_append = SIGIL_C.instantiate()
			Level.Sigil.D:
				to_append = SIGIL_D.instantiate()
			Level.Sigil.E:
				to_append = SIGIL_E.instantiate()
			Level.Sigil.F:
				to_append = SIGIL_F.instantiate()
				
		to_append.position.x = 16 * n
		
		queue.append(to_append)
		add_child(to_append)
		n += 1
		
		
				
