class_name Player
extends CharacterBody2D

@export var speed := 75.0

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D
@onready var _bark_indicator: Label = $Bark
@onready var _dialogue_indicator: Label = $Dialogue

var _nearby_objects: Array[Interactable] = []
var _current_interactable: Interactable = null

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO

	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1

	velocity = velocity.normalized() * speed
	move_and_slide()
	_face_direction(velocity)
	
	if Input.is_action_just_pressed("B"):
		_bark()
	
	if Input.is_action_just_pressed("A") and _current_interactable != null:
		_trigger_interaction()


func register_interactable(object: Interactable) -> void:
	_nearby_objects.append(object)
	_current_interactable = _nearby_objects.back()


func unregister_interactable(object: Interactable) -> void:
	_nearby_objects.erase(object)
	if _nearby_objects.is_empty():
		_current_interactable = null
	else:
		_current_interactable = _nearby_objects.back()


func get_horizontal_collision() -> Vector2:
	var shape = _collision_shape.shape
	var half_width = shape.size.x * 0.5
	return Vector2(
			_collision_shape.position.x - half_width,
			_collision_shape.position.x + half_width
	)


func _trigger_interaction() -> void:
	# BASIC PLACEHOLDER IMPLEMENTATION
	_current_interactable.print_dialogue()
	_dialogue_indicator.text = _current_interactable.interact()
	_dialogue_indicator.show()
	await get_tree().create_timer(1).timeout
	_dialogue_indicator.hide()


func _bark() -> void:
	_bark_indicator.show()
	await get_tree().create_timer(0.25).timeout
	_bark_indicator.hide()


func _face_direction(direction: Vector2) -> void:
	if direction.x > 0:
		$Sprite2D.flip_h = true
	elif direction.x < 0:
		$Sprite2D.flip_h = false
