extends Node2D


const DAMAGE = 34
var dps = 0
var damagePastSecond = 0
var critChance = 1.0/10
var critModifier = 1.5

var rng = RandomNumberGenerator.new()


onready var ANIMATION = $AnimatedSprite


signal attacked(damage)
signal newDps(dps)

func _ready():
	ANIMATION.connect("animation_finished", self, "startIdle")
	

func startIdle():
	ANIMATION.play("idle")

func attack():
	var dealtDamage = DAMAGE
	
	# Adding modifiers
	if(rng.randf() < critChance):	
		print(rng.randf())	
		ANIMATION.play("crit")
		dealtDamage *= critModifier
		
	
	emit_signal("attacked", dealtDamage)
	damagePastSecond += dealtDamage
	
	if ANIMATION.animation == "idle":
		ANIMATION.play("attack")


func secondPassed():
	if damagePastSecond == 0:
		dps = 0
	else:
		dps = (dps + damagePastSecond) / 2
	
	emit_signal("newDps", dps)
	damagePastSecond = 0


func executeSkill(skillNumber):
	print(skillNumber)
	
	match skillNumber:
		0:
			firstSkill()
		1:
			secondSkill()
		2:
			thirdSkill()
		3:
			fourthSkill()
		_:
			print("got a skillNumber which is not a skill")
			
func firstSkill():
	pass
	
func secondSkill():
	pass
	
func thirdSkill():
	pass
	
func fourthSkill():
	pass
	
