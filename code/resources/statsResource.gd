class_name statsResource extends Resource

signal healthChanged(current: int, max: int)
signal hasDied

enum BuffableStats {
	MAX_HEALTH,
	DAMAGE,
	HEALING,
}

const STAT_CURVES: Dictionary[BuffableStats, Curve] = {
	BuffableStats.MAX_HEALTH: preload("uid://6gqm4gl558bj"),
	BuffableStats.DAMAGE: preload("uid://c1ctiq3hx3baw"),
	BuffableStats.HEALING: preload("uid://by0hry3pt2uxv")
}

const BASE_LEVEL_EXP: int = 100

@export var baseMaxHealth: int = 5
@export var baseDamage: int = 1
@export var baseHealing: int = 1

var level: int:
	get(): return floor(max(1, sqrt(experience/100) + 0.5))
var currentMaxHealth: int = 5
var currentDamage: int = 1
var currentHealing: int = 1

var experience: int = 0: set = onExperienceSet
var health: int = 0: set = onHealthSet

func _init() -> void:
	setupStats.call_deferred()

func setupStats() -> void:
	# recalculate the current stats first
	health = currentMaxHealth



func recalculateStats() -> void:
	var statsSamplePos: float = (float(level) / 100.0) - 0.01
	currentMaxHealth = baseMaxHealth * STAT_CURVES[BuffableStats.MAX_HEALTH].sample(statsSamplePos)



func onHealthSet(newValue: int) -> void:
	health = clampi(newValue, 0, currentMaxHealth)
	healthChanged.emit(health, currentMaxHealth)
	if health <= 0:
		hasDied.emit()

func onExperienceSet(newValue: int) -> void:
	var oldLevel: int = level
	experience = newValue
	
	if oldLevel != level:
		recalculateStats()
