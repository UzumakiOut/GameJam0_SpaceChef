extends Node3D

var printerStartingLocation = Vector3(0.0, 2.0, 0.0);
var printerEndingLocation = Vector3(0.0, 0.0, 0.0);
@export var printerMoveSpeed = 1.0
var cameraBobSpeedAndDirection = Vector3(0.0,-0.02,0.0)
var canSound = true

func _ready():
	printerFakeOut();

#func _input(event):
	#if event.is_action_pressed("TestKey1"):
		#$AnimationPlayer.stop()
		#$AnimationPlayer.play("printerMoveDown");
		

	#if event.is_action_pressed("TestKey2"):
		#$AnimationPlayer.stop()
		#$AnimationPlayer.play("printerMoveUp");
	

	#if event.is_action_pressed("TestKey3"):
		#$AnimationPlayer.stop()
		#$AnimationPlayer.play("printerCookingFastest");
		


func printerFakeOut():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("printerMoveDown");
	await get_tree().create_timer(0.6).timeout
	printerCook();
	
func printerCook():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("printerCookingSlow");
	await get_tree().create_timer(1.0).timeout
	printerGoUp();
	
func printerGoUp():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("printerMoveUp");
	await get_tree().create_timer(0.6).timeout
	printerFakeOut();
	






#func sendPrinterDown()
	#$AnimationPlayer.play(printerMoveDown)



