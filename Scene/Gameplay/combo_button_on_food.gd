extends Node3D


@export var arrowValue = 0; # 0 is off, 1 = up, 2 = down, 3 = left, 4 = right, 5 = space, 6 = mystery
@onready var ArrowUp = $ArrowUp
@onready var ArrowDown = $ArrowDown
@onready var ArrowLeft = $ArrowLeft
@onready var ArrowRight = $ArrowRight
@onready var ArrowSpace = $ArrowSpace
@onready var ArrowQuestion = $ArrowQuestion
@export var arrowColor = Color(0,1,0)


func _ready():
	ArrowUp.visible = false
	ArrowDown.visible = false
	ArrowLeft.visible = false
	ArrowRight.visible = false
	ArrowSpace.visible = false
	ArrowQuestion.visible = false
	
	#set visibility based on valid number
	#timer added so that way variables can be passed without causing issues.
	await get_tree().create_timer(0.1).timeout
	if arrowValue == null: #this should never happen within the code
		arrowValue = 0;
	if arrowValue <= 0: #if the value is below intended range, set it to zero
		arrowValue = 0;
	if arrowValue == 1:
		ArrowUp.visible = true
		if Global.spookyMode == true:
			ArrowUp.visible = false
			ArrowQuestion.visible = true;
	if arrowValue == 2:
		ArrowDown.visible = true
		if Global.spookyMode == true:
			ArrowDown.visible = false
			ArrowQuestion.visible = true;
	if arrowValue == 3:
		ArrowLeft.visible = true
		if Global.spookyMode == true:
			ArrowLeft.visible = false
			ArrowQuestion.visible = true;
	if arrowValue == 4:
		ArrowRight.visible = true
		if Global.spookyMode == true:
			ArrowRight.visible = false
			ArrowQuestion.visible = true;
	if arrowValue == 5:
		ArrowSpace.visible = true
		if Global.spookyMode == true:
			ArrowSpace.visible = false
			ArrowQuestion.visible = true;
	if arrowValue >= 5: #if the value is too high, we also set it to zero
		arrowValue = 0;

func setArrowColorCorrect():
	arrowColor = Color (0,1,0)
	ArrowUp.arrowColor = arrowColor
	ArrowDown.arrowColor = arrowColor
	ArrowLeft.arrowColor = arrowColor
	ArrowRight.arrowColor = arrowColor
	ArrowSpace.arrowColor = arrowColor
	ArrowQuestion.arrowColor = arrowColor
	$AnimationPlayer.play("ButtonHit");

func setArrowColorIncorrect():
	arrowColor = Color (1,0,0)
	ArrowUp.arrowColor = arrowColor
	ArrowDown.arrowColor = arrowColor
	ArrowLeft.arrowColor = arrowColor
	ArrowRight.arrowColor = arrowColor
	ArrowSpace.arrowColor = arrowColor
	ArrowQuestion.arrowColor = arrowColor;
