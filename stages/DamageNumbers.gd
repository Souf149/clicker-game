extends Control





func spawnNewNumber(damage, position):
	var mySprite = preload("res://DamageNumber.tscn").instance()
	mySprite.init(damage)
	mySprite.set_global_position(position)
	
	print(get_viewport().size)
	add_child(mySprite)
	
