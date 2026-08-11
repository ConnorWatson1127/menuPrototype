class_name Enemy extends CharacterBody2D

@export var health: healthComponent
@export var power: powerComponent
@export var brain: brainComponent
@export var movement: movementComponent

var wantsAttack: bool = false

func _ready() -> void:
	health.hasDied.connect(onDied)

func _physics_process(delta: float) -> void:
	brain.update()
	
	movement.direction = brain.direction.normalized()
	movement.tick(delta)

func onDied() -> void:
	print("enemy died! :)")
