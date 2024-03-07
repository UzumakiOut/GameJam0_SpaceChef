extends Node3D


@export var arrowValue = 1; # 0 is off, 1 = up, 2 = down, 3 = left, 4 = right, 5 = space.


# Called when the node enters the scene tree for the first time.
func _ready():
	#For some reason when I use any of the surface_material_overrides or whatevers, it doesn't work and crashes. I'll just do this the lame and unoptimized way.
	$ArrowUp.visible = false;
	$ArrowDown.visible = false;
	$ArrowLeft.visible = false;
	$ArrowRight.visible = false;
	$ArrowSpace.visible = false;
	
	#set visibility based on valid number
	#timer added so that way variables can be passed without causing issues.
	await get_tree().create_timer(0.1).timeout
	if arrowValue == null: #this should never happen within the code
		arrowValue = 0;
	if arrowValue <= 0: #if the value is below intended range, set it to zero
		arrowValue = 0;
	if arrowValue == 1:
		$ArrowUp.visible = true;
	if arrowValue == 2:
		$ArrowDown.visible = true;
	if arrowValue == 3:
		$ArrowLeft.visible = true;
	if arrowValue == 4:
		$ArrowRight.visible = true;
	if arrowValue == 5:
		$ArrowSpace.visible = true;
	if arrowValue >= 5: #if the value is too high, we also set it to zero
		arrowValue = 0;

func buttonTriggered():
	var incomingButtonValueTrigger = 0
	if incomingButtonValueTrigger == arrowValue:
		visible = false;
	
