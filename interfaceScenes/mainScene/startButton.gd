extends TextureButton

signal startGame

func _pressed():
	emit_signal("startGame")
	
