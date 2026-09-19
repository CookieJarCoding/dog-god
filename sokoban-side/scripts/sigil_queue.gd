extends Node2D
class_name SigilQueue

var SIGIL_A = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_a.tscn")
var SIGIL_B = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_b.tscn")
var SIGIL_C = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_c.tscn")
var SIGIL_D = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_d.tscn")
var SIGIL_E = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_e.tscn")
var SIGIL_F = preload("res://sokoban-side/objects/queue_sigils/queue_sigil_f.tscn")

var queue : Array[QueueSigil] = []

func _enter_tree() -> void:
	Level.sigil_queue = self

	construct_queue()
		
func construct_queue() -> void:
	var x = 0
	for qs in Level.lvl_data.sigil_queue:
		var new_sigil = make_sigil(qs).instantiate()
		new_sigil.position.x = 16*x
		add_child(new_sigil)
		queue.append_array([new_sigil])

		x += 1
	

func _exit_tree() -> void:
	Level.sigil_queue = null
	
func make_sigil(sigil: Level.Sigil) -> PackedScene:
	match sigil:
		Level.Sigil.A:
			return SIGIL_A
		Level.Sigil.B:
			return SIGIL_B
		Level.Sigil.C:
			return SIGIL_C
		Level.Sigil.D:
			return SIGIL_D
		Level.Sigil.E:
			return SIGIL_E
		_:
			return SIGIL_F
			
func pop_first_at_queue() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(queue[0], "position", Vector2(0, 16), 0.5)
	
	queue.pop_front()
	
	for qs in queue:
		var target_pos := Vector2(qs.position.x - 16, 0)
		
		tween.tween_property(qs, "position", target_pos, 0.3)

func add_sigil_at_front(s: Level.Sigil) -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	for qs in queue:
		var target_pos := Vector2(qs.position.x + 16, 0)
		
		tween.tween_property(qs, "position", target_pos, 0.3)
		
	var new_sigil = make_sigil(s).instantiate()
	new_sigil.position.y = 16
	add_child(new_sigil)
	queue.push_front(new_sigil)
	
	tween.tween_property(new_sigil, "position", Vector2(0, 0), 0.5)
	
