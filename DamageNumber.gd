extends RigidBody2D


var rng = RandomNumberGenerator.new()
var timer = 250

func _process(_delta):
	timer -= 1
	if timer <= 0:
		print("FREE")
		queue_free()
	

func _ready():
	
	rng.randomize()
	var _x = rng.randi_range(-100, 100)
	var _y = rng.randi_range(1, 100)
	
	apply_central_impulse(Vector2(_x, _y))

func init(number):
	$Label.text = str(number)
	
