extends Control





func spawnNewNumber(damage, position):
	var mySprite = preload("res://DamageNumber.tscn").instance()
	mySprite.init(damage)
	mySprite.position = position
	add_child(mySprite)
