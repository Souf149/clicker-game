extends TextureButton

signal leftButton

func _ready():
	pass

func _pressed():
	emit_signal("leftButton", -1)
