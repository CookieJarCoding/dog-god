class_name Player
extends CharacterBody2D

@export var speed := 75.0

var _dialogue_manager: DialogueManager

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D 
@onready var _bark_indicator: Label = $Bark

var _nearby_objects: Array[Interactable] = []
var _current_interactable: Interactable = null
var _is_barking := false


func _ready() -> void:
	_dialogue_manager = DialogueManager.get_instance(get_tree())


func _physics_process(_delta: float) -> void:
	_handle_animation()
	velocity = Vector2.ZERO
	if _dialogue_manager != null and _dialogue_manager.is_active:	
		# Disable all movement and controls when dialogue is playing
		return

	if Input.is_action_pressed("right") && not _is_barking:
		velocity.x += 1
	if Input.is_action_pressed("left") && not _is_barking:
		velocity.x -= 1

	velocity = velocity.normalized() * speed
	move_and_slide()
	_face_direction(velocity)
	
	if Input.is_action_just_pressed("B"):
		_bark()
	
	if Input.is_action_just_pressed("A") and _current_interactable != null:
		_current_interactable.interact()


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


func _bark() -> void:
	_is_barking = true
	await get_tree().create_timer(0.20).timeout
	_is_barking = false


func _face_direction(direction: Vector2) -> void:
	if direction.x > 0:
		_sprite.flip_h = true
	elif direction.x < 0:
		_sprite.flip_h = false

func _handle_animation() -> void:
	if _is_barking:
		_sprite.play("bark")
	elif velocity.x != 0:
		_sprite.play("walk")
	else:
		_sprite.play("idle")
