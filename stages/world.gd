extends Node2D

var slimeEnemy = preload("res://enemies/Slime/Slime.tscn")
var screenSize
# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size
	print(screenSize)
	var slime = Global.instance_node(slimeEnemy, Vector2(screenSize, screenSize.y*0.5), self)
	print(slime.global_position)
	
	
