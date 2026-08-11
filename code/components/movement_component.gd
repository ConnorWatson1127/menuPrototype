class_name movementComponent extends Node

@export var body: CharacterBody2D
@export var speed: float = 100.0

var direction: Vector2 = Vector2.ZERO

func tick(delta: float) -> void:
	#check for a body
	if !body:
		return
	
	# use input to move character
	body.velocity.x = direction.x * speed
	body.velocity.y = direction.y * speed
	body.move_and_slide()
