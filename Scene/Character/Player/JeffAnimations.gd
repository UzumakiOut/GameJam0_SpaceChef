extends Node3D

var isAlive = true
var canDie = true
@export var jeffMainMenu = false
var executionDelay = 0.0
var randAnimInt = 1

func _ready():
	if jeffMainMenu == true:
		$AnimationPlayer.set_speed_scale(1.0);
	else:
		$AnimationPlayer.set_speed_scale(2.0);
	runIdleAnim();

func _process(_delta):
	if Global.globalHealthPointsCurrent == 0:
		isAlive = false
		runDeathAnim();


func _input(event):
	if isAlive == true:
		if event.is_action_pressed("UpArrow"):
			$AnimationPlayer.stop()
			$AnimationPlayer.play("ANIM_JeffAction1")
			$JeffSounds.play();
			runIdleAnim();

		if event.is_action_pressed("DownArrow"):
			$AnimationPlayer.stop()
			$AnimationPlayer.play("ANIM_JeffAction4")
			$JeffSounds.play();
			runIdleAnim();

		if event.is_action_pressed("LeftArrow"):
			$AnimationPlayer.stop()
			$AnimationPlayer.play("ANIM_JeffAction2")
			$JeffSounds.play();
			runIdleAnim();

		if event.is_action_pressed("RightArrow"):
			$AnimationPlayer.stop()
			$AnimationPlayer.play("ANIM_JeffAction3")
			$JeffSounds.play();
			runIdleAnim();

		if event.is_action_pressed("Spacebar"):
			$AnimationPlayer.stop()
			$AnimationPlayer.play("ANIM_JeffSick")
			$JeffSounds.play();
			runIdleAnim();

	else:
		runDeathAnim();
		
func runDeathAnim():
	if canDie == true:
		canDie = false #can't die if you are dead
		Global.globalisDead = true
		$AnimationPlayer.stop()
		$AnimationPlayer.clear_queue()
		$AnimationPlayer.play("ANIM_JeffFailure");
		await get_tree().create_timer(2.0).timeout
		SceneTransition.change_scene("res://MainMenu.tscn");

func runIdleAnim():
	$AnimationPlayer.queue("ANIM_JeffIdle")
	executionDelay = 7.5
	randAnimInt = randi_range(1, 5)
	if randAnimInt == 1:
		$AnimationPlayer.queue("ANIM_JeffFreakOut")
		executionDelay += 2.5;
	if randAnimInt == 2:
		$AnimationPlayer.queue("ANIM_JeffJoy2")
		executionDelay += 1.7;
	if randAnimInt == 3:
		$AnimationPlayer.queue("ANIM_JeffMistake2")
		executionDelay += 0.8;
	if randAnimInt == 4:
		$AnimationPlayer.queue("ANIM_JeffSick")
		executionDelay += 1.7;
	if randAnimInt == 5:
		pass
	await get_tree().create_timer(executionDelay).timeout
	if isAlive == true:
		runIdleAnim();
