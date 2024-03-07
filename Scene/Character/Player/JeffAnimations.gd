extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("ANIM_JeffIdle");

func _input(event):
	if event.is_action_pressed("UpArrow"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffAction1")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");
		
	if event.is_action_pressed("DownArrow"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffAction4")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");
		
	if event.is_action_pressed("LeftArrow"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffAction2")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");

	if event.is_action_pressed("RightArrow"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffAction3")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");

	if event.is_action_pressed("Spacebar"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffSick")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");

	if event.is_action_pressed("TestKey1"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffFreakOut")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");

	if event.is_action_pressed("TestKey2"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffMistake1")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");

	if event.is_action_pressed("TestKey3"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ANIM_JeffJoy1")
		$JeffSounds.play();
		$AnimationPlayer.queue("ANIM_JeffIdle");
