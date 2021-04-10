extends KinematicBody2D

onready var healthBar = $HealthBar/HealthBar

signal dead

func takeDamage(damage: int):
	print(damage)
	healthBar.value -= damage
	
	if(healthBar.value <= 0):
		emit_signal("dead")

	
