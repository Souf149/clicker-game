extends Control

onready var HEALTH_BAR = $HealthBar
onready var LABEL = $HealthBar/Label

func _ready():
	LABEL.text = str(HEALTH_BAR.value)





func _on_HealthBar_value_changed(value):
	LABEL.text = str(value)
