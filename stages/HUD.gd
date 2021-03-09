extends CanvasLayer

signal skillButtonPressed(skillNumber)

const DEFAULT_TEXT = "DPS: "

func _ready():
	$Label.text = DEFAULT_TEXT + str(0)



func _on_DemonHunter_newDps(dps):
	$Label.text = DEFAULT_TEXT + str(dps)

func skillButtonPressed(skillNumber):
	emit_signal("skillButtonPressed", skillNumber)
