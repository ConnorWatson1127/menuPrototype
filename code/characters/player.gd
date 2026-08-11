class_name Player extends Node2D

@export var health: healthComponent
@export var power: powerComponent
@export var input: inputComponent
@export var movement: movementComponent

var wantsAttack: bool = false

func _ready() -> void:
	health.hasDied.connect(onDied)

func _physics_process(delta: float) -> void:
	#read controlls
	input.update()
	
	if input.damagePressed:
		health.takeDamage(power.damage)
		input.damagePressed = false
	if input.healPressed:
		health.heal(power.heal)
		input.healPressed = false
	
	#read movement component
	movement.direction = input.direction
	movement.tick(delta)

func onDied() -> void:
	print("player died! :(")
