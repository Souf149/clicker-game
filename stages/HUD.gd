extends CanvasLayer

const DEFAULT_TEXT = "DPS: ";

func _ready():
	$Label.text = DEFAULT_TEXT + str(0)



func _on_DemonHunter_newDps(dps):
	$Label.text = DEFAULT_TEXT + str(dps)
