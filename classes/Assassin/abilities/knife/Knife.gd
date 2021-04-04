extends KinematicBody2D

var timer = 0
var clickable = true

signal onClick


func _ready():
	modulate.a = 0.1

func _process(delta):

	if timer < 2:
		timer+=delta
		modulate.a += 0.001
		
	else:
		if clickable: queue_free()
		position += Vector2(10, 10)
		rotate(0.15)
		modulate.a += 0.01

func _input_event(_viewport, event, shape_idx):
	if event.is_pressed() and clickable:
		emit_signal("onClick", shape_idx)
		$Sprite.self_modulate.r = 200
		clickable = false
