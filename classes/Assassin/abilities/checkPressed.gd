extends CollisionPolygon2D

signal clicked

func _unhandled_input(event):
	if Input.is_action_just_pressed("onTap"):
		emit_signal("clicked")
