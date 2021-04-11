extends Node2D

var slimeEnemy = preload("res://enemies/Slime/Slime.tscn")
var screenSize
var currentEnemy
var enemiesKilled = 0

onready var EnemyRespawnTimer = $EnemyRespawnTimer
onready var player = $player

signal attacked(damage)
signal enemyDied
signal enemySpawned

func _ready():
	_spawnEnemy()
	
	

func _on_enemy_death():
	print("Death")
	emit_signal("enemyDied")
	EnemyRespawnTimer.start()
	enemiesKilled += 1

func _spawnEnemy():
	print("SPAWNING ENEMY")
	screenSize = get_viewport_rect().size
	var _position = player.global_position
	_position.x += screenSize.x/4
	currentEnemy = Global.instance_node(slimeEnemy, _position, self)
	self.connect("attacked", currentEnemy, "takeDamage")
	currentEnemy.connect("dead", self, "_on_enemy_death")

func _on_attacked(damage):
	emit_signal("attacked", damage)


func _on_EnemyRespawnTimer_timeout():
	emit_signal("enemySpawned")
	_spawnEnemy()
