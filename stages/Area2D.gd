extends Area2D

signal clicked

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		emit_signal("clicked")
