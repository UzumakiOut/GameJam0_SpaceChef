extends Node3D

#references
@onready var Anim = $AnimationPlayer
@onready var Parent = ""

#editor values
@export var animAttack = 1   # attack anim. 1 = slap, 2 = sting, 3 = swipe

#animation
var canIdle = true
var executionDelay = 0
var canAttack = true

func _ready():
	tentacleAnimationIdle();



func tentacleAnimationIdle():
	Anim.stop()
	Anim.play("ANIM_TentIdle")
	executionDelay = 7.5
	await get_tree().create_timer(executionDelay).timeout
	if canIdle == true:
		tentacleAnimationIdle();

func tentAnimAttack():
	if canAttack == true:
		Anim.stop()
		canAttack = false
		canIdle = false
		executionDelay = 1.6
		if animAttack == 1:
			Anim.play("ANIM_TentAttack1");
		elif animAttack == 2:
			Anim.play("ANIM_TentAttack2");
		elif animAttack == 3:
			Anim.play("ANIM_TentAttack3");
		else:
			tentacleAnimationIdle()
			print("TENTACLE ATTACK VALUE PARAMETER BAD!");
		await get_tree().create_timer(executionDelay).timeout
		canIdle = true
		canAttack = true
		tentacleAnimationIdle();
