extends Node2D


const DAMAGE = 34
var dps = 0
var damagePastSecond = 0
var critChance = 1.0/10
var critModifier = 1.5
var ableToAttack = true

var rng = RandomNumberGenerator.new()
var knifes = []

onready var ANIMATION = $AnimatedSprite
var knifeNode = preload("res://classes/Assassin/abilities/Knife.tscn")
var kunaiNode = preload("res://classes/Assassin/abilities/Kunai.tscn")

var skillCooldowns = [0.0, 0.0, 0.0, 0.0, 0.0]

var firstSkillTimer = 0

signal attacked(damage)
signal newDps(dps)

func _ready():
	ANIMATION.connect("animation_finished", self, "startIdle")
	
func _process(delta):

	for index in range(skillCooldowns.size()):
		if(skillCooldowns[index] > 0):
			skillCooldowns[index] -= delta;
	
	if firstSkillTimer > 0:
		firstSkillTimer -= delta;
	else:
		ableToAttack = true
		modulate.a = 1
	

func startIdle():
	ANIMATION.play("idle")

func attack():
	if not ableToAttack: return
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
	if skillCooldowns[0] > 0: return
		
	ableToAttack = false
	modulate.a = 0.1
	firstSkillTimer = 3
	skillCooldowns[0] = 5
	
func secondSkill():
	if skillCooldowns[1] > 0: return
	for i in range(10):
		var knife: KinematicBody2D = Global.instance_node(knifeNode, global_position, self)
		knife.global_position += Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, 100))
		knifes.append(knife)
		knife.connect("clicked", self, "_onKnifeClick")
	skillCooldowns[1] = 5

func _onKnifeClick():
	print("SOUF")
	
func thirdSkill():
	if skillCooldowns[2] > 0: return
	Global.instance_node(kunaiNode, global_position, self)
	skillCooldowns[2] = 5
	
func fourthSkill():
	return # Passive ability

func fifthSkill():
	if skillCooldowns[4] > 0: return
	skillCooldowns[4] = 5

	
