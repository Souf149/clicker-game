extends KinematicBody2D

onready var healthBar = $HealthBar/HealthBar

signal dead

var dying = false
var timeLeft = 1


func takeDamage(damage: int):
	if not dying:
		print(damage)
		healthBar.value -= damage
		print(healthBar.value)

	
	if(healthBar.value <= 0 and not dying):
		print("Health: " + str(healthBar.value))
		emit_signal("dead")
		dying = true

func _process(delta):
	if dying:
		modulate.a -= delta
		timeLeft -= delta
		if timeLeft <= 0:
			queue_free()


	
	
