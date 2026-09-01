class_name Enemy extends CharacterBody2D

signal initializeFight

const ENEMY_SCENE: PackedScene = preload("res://scenes/characters/enemy.tscn")

@export var brain: brainComponent
@export var movement: movementComponent

static func new_enemy() -> Enemy:
	var new_enemy: Enemy = ENEMY_SCENE.instantiate()
	return new_enemy

func _physics_process(delta: float) -> void:
	brain.update()
	
	var direction = brain.direction.normalized()
	
	movement.direction.x = direction.x
	movement.direction.y = direction.y
	movement.tick(delta)

func onDied() -> void:
	print("enemy died! :)")

func _on_battle_init_detector_body_entered(body: Node2D) -> void:
	if body.name != "player":
		return
	initializeFight.emit()
	print_debug("Fight Started!")
