class_name Player extends CharacterBody2D

@export var stats: statsResource
@export var input: inputComponent
@export var movement: movementComponent

var wantsAttack: bool = false

func _ready() -> void:
	stats.hasDied.connect(onDied)

func _physics_process(delta: float) -> void:
	#read controlls
	input.update()
	
	if input.damagePressed:
		stats.takeDamage(stats.damage)
		input.damagePressed = false
	if input.healPressed:
		stats.heal(stats.healing)
		input.healPressed = false
	
	#read movement component
	movement.direction = input.direction
	movement.tick(delta)

func onDied() -> void:
	print("player died! :(")
