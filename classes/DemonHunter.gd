extends Node2D


var damage = 34
var dps = 0
var damagePastSecond = 0

onready var ANIMATION = $AnimatedSprite


signal attacked(damage)
signal newDps(dps)

func _ready():
	ANIMATION.connect("animation_finished", self, "startIdle")


func startIdle():
	ANIMATION.play("idle")

func attack():
	emit_signal("attacked", damage)
	damagePastSecond += damage
	
	if ANIMATION.animation != "attack":
		ANIMATION.play("attack")


func secondPassed():
	if damagePastSecond == 0:
		dps = 0
	else:
		dps = (dps + damagePastSecond) / 2
	
	emit_signal("newDps", dps)
	damagePastSecond = 0
