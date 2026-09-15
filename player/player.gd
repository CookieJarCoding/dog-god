extends CharacterBody2D
class_name Player

@export var speed := 75.0

func _process(_delta):
	velocity = Vector2.ZERO

	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1

	velocity = velocity.normalized() * speed
	move_and_slide()
