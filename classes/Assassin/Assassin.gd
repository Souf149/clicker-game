extends Node2D


const DAMAGE = 34
var dps = 0
var damagePastSecond = 0
var critChance = 1.0/10
var critModifier = 1.5
var clickable = true

var rng = RandomNumberGenerator.new()
var knifes = []

onready var ANIMATION = $AnimatedSprite
var knifeNode = preload("res://classes/Assassin/abilities/Knife.tscn")
var kunaiNode = preload("res://classes/Assassin/abilities/Kunai.tscn")

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
		4:
			fifthSkill()
		_:
			print("got a skillNumber which is not a skill")
			
func firstSkill():
	clickable = false
	$cdSkill1.start()
	
func secondSkill():
	for i in range(10):
		var knife = Global.instance_node(knifeNode, global_position, self)
		knife.global_position += Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, 100))
		knifes.append(knife)
	$cdSkill2.start()
	
	
func thirdSkill():
	Global.instance_node(kunaiNode, global_position, self)
	$cdSkill3.start()
	
func fourthSkill():
	pass
	$cdSkill4.start()

func fifthSkill():
	pass
	$cdSkill5.start()

	
