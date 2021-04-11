extends Node2D


const DAMAGE = 34
var dps = 0
var damagePastSecond = 0
var critChance = 1.0/10
var critModifier = 1.5
var ableToAttack = true
var clickedKnifes = 0

var rng = RandomNumberGenerator.new()
var knifes = []

onready var ANIMATION = $AnimatedSprite
onready var KNIFE_TIMER = $KnifeTimer

var knifeNode = preload("res://classes/Assassin/abilities/knife/Knife.tscn")
var kunaiNode = preload("res://classes/Assassin/abilities/kunai/Kunai.tscn")

var skillCooldowns = [0.0, 0.0, 0.0, 0.0, 0.0]

var firstSkillTimer = 0

signal attacked(damage)
signal newDps(dps)

func _ready():
	ANIMATION.connect("animation_finished", self, "animationFinished")
	
func _process(delta):
	if ANIMATION.animation == "walk":
		position += Vector2(1, 0)
	for index in range(skillCooldowns.size()):
		if(skillCooldowns[index] > 0):
			skillCooldowns[index] -= delta;
	
	if firstSkillTimer > 0:
		firstSkillTimer -= delta;
	else:
		ableToAttack = true
		modulate.a = 1
	

func animationFinished():
	print("TRIGGERED")
	if ANIMATION.animation == "walk": return
	ANIMATION.play("idle")

func attack(damage = DAMAGE):
	if not ableToAttack: return
	var dealtDamage = damage
	
	# Adding modifiers
	if(rng.randf() < critChance):
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
	for _i in range(10):
		var knife: KinematicBody2D = Global.instance_node(knifeNode, global_position, self)
		knife.global_position += Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, 100))
		knifes.append(knife)
		knife.connect("onClick", self, "_onKnifeClick")
	
	KNIFE_TIMER.start()
	skillCooldowns[1] = 5

func _onKnifeClick(shape_idx):
	clickedKnifes += 1
	
func thirdSkill():
	if skillCooldowns[2] > 0: return
	Global.instance_node(kunaiNode, global_position, self)
	attack(100)
	skillCooldowns[2] = 5
	
func fourthSkill():
	return # Passive ability

func fifthSkill():
	if skillCooldowns[4] > 0: return
	skillCooldowns[4] = 5

	


func _on_KnifeTimer_timeout():
	attack(clickedKnifes * 10)
	clickedKnifes = 0;


func _on_world_enemyDied():
	ableToAttack = false
	ANIMATION.play("walk")


func _on_world_enemySpawned():
	ableToAttack = true
	ANIMATION.play("idle")
