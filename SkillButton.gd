extends Button

signal skillButtonPressed(number)
var skillNumber = -1

func _ready():

	self.connect("pressed", self, "_button_pressed")
	skillNumber = self.name.substr(self.name.length() - 1, 1)


func _button_pressed():
	emit_signal("skillButtonPressed", int(skillNumber))

