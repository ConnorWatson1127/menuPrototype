class_name main extends Node2D

var currentLevelRoot: Node = null

var player: CharacterBody2D = null
var enemy: CharacterBody2D = null

var score: int = 0
var timeElapsed: float = 0.0

func _ready() -> void:
	currentLevelRoot = get_node("Field")
	var levelName = currentLevelRoot.get_name()
	loadLevel(levelName, null)

# level swapping

func loadLevel(levelName: String, foe: CharacterBody2D) -> void:
	if currentLevelRoot:
		currentLevelRoot.queue_free()
	
	# change level
	var levelPath = "res://scenes/%s.tscn" % levelName
	currentLevelRoot = load(levelPath).instantiate()
	add_child(currentLevelRoot)
	currentLevelRoot.name = "levelRoot"
	
	if levelName == "Field":
		setupField(currentLevelRoot)
	if levelName == "Battle":
		setupBattle(currentLevelRoot, foe)

# setup functions

func setupField(levelRoot: Node) -> void:
	#connect player node reference
	var _player = levelRoot.get_node_or_null("player")
	if _player:
		player = _player
	
	# connect enemy node reference
	var _enemy = levelRoot.get_node_or_null("enemy")
	if _enemy:
		enemy = _enemy
		enemy.initializeFight.connect(onFightInitialized)

func setupBattle(levelRoot: Node, foe: CharacterBody2D) -> void:
	add_child(Enemy.new_enemy())

# connected signals

func onFightInitialized() -> void:
	loadLevel("Battle", enemy)
