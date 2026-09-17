extends CharacterBody2D
class_name Player

@export var speed := 75.0

@onready var collision_shape = $CollisionShape2D
@onready var bark_indicator = $"Label-Bark"
@onready var dialogue_indicator = $"Label-Dialogue"

var current_interactable: Area2D = null

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO

	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1

	velocity = velocity.normalized() * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("B"):
		bark();
	
	if Input.is_action_just_pressed("A") and current_interactable != null:
		trigger_interaction()

func bark() -> void:
	bark_indicator.show()
	await get_tree().create_timer(0.25).timeout
	bark_indicator.hide()

func trigger_interaction() -> void:
	# BASIC PLACEHOLDER IMPLEMENTATION
	current_interactable.print_dialogue()
	dialogue_indicator.text = current_interactable.interact_dialogue
	dialogue_indicator.show()
	await get_tree().create_timer(1).timeout
	dialogue_indicator.hide()

func get_horizontal_collision() -> Vector2:
	var shape = collision_shape.shape
	var half_width = shape.size.x * 0.5
	return Vector2(collision_shape.position.x - half_width, collision_shape.position.x + half_width)
