class_name brainComponent extends Node

var direction: Vector2 = Vector2.ZERO
var player: Player
@export var enemy: Enemy

func update() -> void:
	if !player:
		return
	direction = player.global_position - enemy.global_position

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body

func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player = null
