extends Area2D

signal clicked

func _input_event(_viewport, event, _shape_idx):
	if Input.is_action_just_pressed("onTap"):
		emit_signal("clicked")
