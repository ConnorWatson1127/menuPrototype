class_name inputComponent extends Node

var direction: Vector2 = Vector2.ZERO

var damagePressed: bool = false
var healPressed: bool = false
var pauseToggled: bool = false

func update() -> void:
	direction = Input.get_vector("moveLEFT", "moveRIGHT", "moveUP", "moveDOWN")
	pauseToggled = Input.is_action_just_pressed("pause")
	damagePressed = Input.is_action_just_pressed("attack")
	healPressed = Input.is_action_just_pressed("heal")
