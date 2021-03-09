extends CanvasLayer

const DEFAULT_TEXT = "Combo: ";

func _ready():
	$Label.text = DEFAULT_TEXT + str(0)




func _on_DemonHunter_attacked(damage, position):
	pass
