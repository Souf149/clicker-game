extends Node2D

const DAMAGE = 50

onready var ANIMATION = $AnimatedSprite


signal attacked(damage, demonHunter)

func _ready():
	ANIMATION.connect("animation_finished", self, "startIdle")


func startIdle():
	ANIMATION.play("idle")

func attack():
	emit_signal("attacked", DAMAGE, self)
	print("ATTACK")
	
	if ANIMATION.animation != "attack":
		ANIMATION.play("attack1")
