extends KinematicBody2D

var timer = 0

signal clicked

func _ready():
	modulate.a = 0.1

func _process(delta):

	if timer < 2:
		timer+=delta
		modulate.a += 0.001
		
	else:
		position += Vector2(10, 10)
		rotate(0.15)
		modulate.a += 0.01
	
	
	


func _on_CollisionPolygon2D_clicked():
	emit_signal("clicked")
