extends Node2D

var slimeEnemy = preload("res://enemies/Slime/Slime.tscn")
var screenSize
var currentEnemy

signal attacked(damage)

func _ready():
	_spawnEnemy()
	
	

func _on_enemy_death():
	print("Death")
	currentEnemy.queue_free()
	_spawnEnemy()

func _spawnEnemy():
	screenSize = get_viewport_rect().size
	var _position = global_position
	_position.x += screenSize.x/4
	_position.y -= screenSize.y/4
	currentEnemy = Global.instance_node(slimeEnemy, _position, self)
	self.connect("attacked", currentEnemy, "takeDamage")
	currentEnemy.connect("dead", self, "_on_enemy_death")

func _on_attacked(damage):
	emit_signal("attacked", damage)
