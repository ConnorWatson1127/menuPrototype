class_name healthComponent extends Node

signal healthChanged(current: int, max: int)
signal hasDied

@export var maxHealth: int = 5
var currentHealth: int

func _ready() -> void:
	currentHealth = maxHealth
	_emit()

func checkHealth():
	if currentHealth <= 0:
		hasDied.emit()

func takeDamage(amount: int) -> void:
	currentHealth = clamp(currentHealth - amount, 0, maxHealth)
	_emit()
	if currentHealth <= 0:
		hasDied.emit()

func heal(amount: int) -> void:
	currentHealth = clamp(currentHealth + amount, 0, maxHealth)
	_emit()

func _emit() -> void:
	healthChanged.emit(currentHealth, maxHealth)
	print_debug("HP: %d / %d" % [currentHealth, maxHealth])
