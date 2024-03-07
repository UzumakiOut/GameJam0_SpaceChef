extends Node3D

var imageArrowStartingScale = Vector3(0.1, 0.1, 0.1);
var imageSpaceStartingScale = Vector3(0.1, 0.1, 0.1);
var imageArrowEndingScale = Vector3(0.2, 0.2, 0.2);
var imageSpaceEndingScale = Vector3(0.2, 0.2, 0.2);
var imageScaleSpeed = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	imageScaleSpeed += delta * 0.4;
	pass

func _input(event):
	if event.is_action_pressed("UpArrow"):
		$ArrowUp.scale = imageArrowEndingScale
		$SFX_Input1.play();
	if event.is_action_released("UpArrow"):
		$ArrowUp.scale = imageArrowStartingScale;
		$SFX_Input2.play();

	if event.is_action_pressed("DownArrow"):
		$ArrowDown.scale = imageArrowEndingScale;
		$SFX_Input1.play();
	if event.is_action_released("DownArrow"):
		$ArrowDown.scale = imageArrowStartingScale;
		$SFX_Input2.play();

	if event.is_action_pressed("LeftArrow"):
		$ArrowLeft.scale = imageArrowEndingScale;
		$SFX_Input1.play();
	if event.is_action_released("LeftArrow"):
		$ArrowLeft.scale = imageArrowStartingScale;
		$SFX_Input2.play();

	if event.is_action_pressed("RightArrow"):
		$ArrowRight.scale = imageArrowEndingScale;
		$SFX_Input1.play();
	if event.is_action_released("RightArrow"):
		$ArrowRight.scale = imageArrowStartingScale;
		$SFX_Input2.play();

	if event.is_action_pressed("Spacebar"):
		$SpaceBar.scale = imageSpaceEndingScale;
		$SFX_Input1.play();
	if event.is_action_released("Spacebar"):
		$SpaceBar.scale = imageSpaceStartingScale;
		$SFX_Input2.play();
