extends TextureButton



signal rightButton

func _pressed():
	emit_signal("rightButton", 1)
