extends Node3D


@export var arrowValue = 0; # 0 is off, 1 = up, 2 = down, 3 = left, 4 = right, 5 = space.
@onready var ArrowUp = $ArrowUp;
@onready var ArrowDown = $ArrowDown;
@onready var ArrowLeft = $ArrowLeft;
@onready var ArrowRight = $ArrowRight;
@onready var Spacebar = $ArrowSpace;
@export var arrowColor = Color(0,1,0);

# Called when the node enters the scene tree for the first time.
func _ready():
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

func _process(_delta):
	pass

func setArrowColorCorrect():
	arrowColor = Color (0,1,0)
	ArrowUp.arrowColor = arrowColor;
	ArrowDown.arrowColor = arrowColor;
	ArrowLeft.arrowColor = arrowColor;
	ArrowRight.arrowColor = arrowColor;
	Spacebar.arrowColor = arrowColor;
	$AnimationPlayer.play("ButtonHit");

func setArrowColorIncorrect():
	arrowColor = Color (1,0,0)
	ArrowUp.arrowColor = arrowColor;
	ArrowDown.arrowColor = arrowColor;
	ArrowLeft.arrowColor = arrowColor;
	ArrowRight.arrowColor = arrowColor;
	Spacebar.arrowColor = arrowColor;
