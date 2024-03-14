extends Node3D

#exposed for editing purposes
var plateMovementRate = 1;
var platePointMultiplier = 1;

#generation
@export var platePregenerated = false
@export var predeterminedComboSize = false
@export var plateDifficulty = 3; #value from 1 - 9
var plateComboDict = {"UpArrow": 1, "DownArrow": 2, "LeftArrow": 3, "RightArrow": 4, "Spacebar": 5};
@export var plateComboArray = [4, 5, 2, 4, 5, 2, 5, 5, 5];
@export var sequence = ["RightArrow", "Spacebar", "DownArrow", "RightArrow", "Spacebar", "DownArrow", "Spacebar", "Spacebar", "Spacebar"];
@onready var buttonSelectionArray = [$Plate/ComboButton1, $Plate/ComboButton2, $Plate/ComboButton3, $Plate/ComboButton4, $Plate/ComboButton5,
$Plate/ComboButton6, $Plate/ComboButton7, $Plate/ComboButton8, $Plate/ComboButton9];

#combo inputting
var sequenceIndex = 0;
var acceptingInput = false;
var correctInput = false;
var completedInput = false;

#item variables for moving it
var plateTrashing = false;
var plateHeld = false
var previousFoodPosition = position
var plateHeldPosition = position
@onready var plateCollision = $FoodArea/CollisionShape3D
var mouseOverObject = false;
var plateDirection = Vector3(0.0,0.0,0.03); #base speed between 1 and 9
var plateSpeed = clamp(Vector3(plateDirection) + (Vector3(0.0, 0.0, Global.globalDifficulty)) * Vector3(0.0,0.0,0.03), Vector3(0.0,0.0,0.3), Vector3(0.0,0.0,0.028));
var increasedSpeed = 1

#points and scoring
@export var plateIsEvil = false
@export var plateIsTrash = false
var platePointValue = 0
@onready var warningText = $WarningText;





func _ready():   #call RNG setting, set pregen stats, generate point values
	initialRNGComboOnItem()
	killTimer()
	if platePregenerated == true:   #i could have done this with a for-break, but i don't care
		$Plate/ComboButton1.arrowValue = plateComboArray[0];
		$Plate/ComboButton2.arrowValue = plateComboArray[1];
		$Plate/ComboButton3.arrowValue = plateComboArray[2]
		$Plate/ComboButton4.arrowValue = plateComboArray[3]
		$Plate/ComboButton5.arrowValue = plateComboArray[4]
		$Plate/ComboButton6.arrowValue = plateComboArray[5]
		$Plate/ComboButton7.arrowValue = plateComboArray[6]
		$Plate/ComboButton8.arrowValue = plateComboArray[7]
		$Plate/ComboButton9.arrowValue = plateComboArray[8];

	platePointValue = platePointMultiplier * (plateDifficulty * 10) +(10 * Global.globalDifficulty);
	if plateIsEvil == true:   #evil plates are negative points
		platePointValue = platePointValue * 1.5
		setWarningText();
	if plateIsTrash == true:   #trash plates are negative points, but not as bad as evil
		platePointValue = platePointValue * 0.5
		setWarningText();


func killTimer():
	await get_tree().create_timer(30).timeout
	queue_free();

func setWarningText():
	if Global.globalDifficultySetting < 5:
		warningText.visible = true;

func initialRNGComboOnItem():   #RNG for the combo buttons as they appear on the food item
	if platePregenerated == false:
		var comboArrayIndex = 0
		var comboArrayCurrentValue = 0
		plateComboArray.resize(0)   #clear array
		sequence.resize(0)
		if predeterminedComboSize == false:
			plateDifficulty = randi_range(3, clamp((3 + (Global.globalDifficulty * 0.5)), 5, 9))   #set array size
		plateComboArray.resize(1);
		for i in plateComboArray:
			comboArrayCurrentValue = randi_range(1, 5)
			plateComboArray.insert(comboArrayIndex, comboArrayCurrentValue)   #set value at index between 1 and 5
			sequence.insert(comboArrayIndex, plateComboDict.find_key(comboArrayCurrentValue))   #sets sequence to associated value
			buttonSelectionArray[comboArrayIndex].arrowValue = comboArrayCurrentValue
			comboArrayIndex += 1;   #this is at the end of each loop
			if comboArrayIndex == plateDifficulty:   #this should break the loop at it's max index
				break
		plateComboArray.resize(plateDifficulty)
		plateComboArray.resize(9);

func _process(_delta):   #all that's here is the code for reading button combos
	if Global.globalisDead == true:
		platePointValue = 0;
	if acceptingInput == true and Global.globalisDead == false:
		if Input.is_action_just_pressed(sequence[sequenceIndex]):
			correctInput = true
			buttonSelectionArray[sequenceIndex].setArrowColorCorrect();
			sequenceIndex += 1;
			if sequenceIndex == sequence.size():
				sequenceIndex = 0
				completedInput = true;
				acceptingInput = false;
				increasedSpeed = 10;   #get the input index, check it, if all are right, make it move faster
		else:
			buttonSelectionArray[sequenceIndex].setArrowColorIncorrect();

func _physics_process(_delta):   #movement of the item
	if plateHeld == false and plateTrashing == false:
		position += (plateSpeed * increasedSpeed) + Vector3(0.0,0.0,(Global.globalHeatingUp * 0.001));
	else:
		position = lerp(position, Global.globalMouseLocationInSpace, 0.1);   #moves the item to the mouse aimed location.

func _on_food_area_area_entered(area):   #check where the plate is colliding with
	if area.is_in_group("Expo"):   #when the item is heading out to award the player
		if completedInput == true:   #first check if input was completed
			if plateIsEvil == true:
				Global.platesCursedAccepted += 1
				Global.scorePoints -= platePointValue   #lose points and take damage
				Global.spookyValue += 100   #increases spooky
				Global.globalHealthPointsCurrent -= 1;
				Global.globalComboLossedHeat()
			if plateIsTrash == true:
				Global.platesTrashAccepted += 1
				Global.scorePoints -= platePointValue * 0.5   #lose points and take damage
				Global.globalHealthPointsCurrent -= 1;
				Global.globalComboLossedHeat()
			else:   #no issues with plate
				Global.scorePoints += platePointValue
				Global.spookyValue -= 25
				Global.platesCompleted += 1
				Global.globalComboHeatingUp();   #speeds up
			queue_free();
		else:   #we didn't complete the input
			if plateIsEvil == true: 
				Global.platesCursedAccepted += 1
				Global.scorePoints -= platePointValue * 0.1
				Global.spookyValue += 50   #increases spooky
				Global.globalHealthPointsCurrent -= 1;
			if plateIsTrash == true:
				Global.platesTrashAccepted += 1
				Global.scorePoints -= platePointValue * 0.1   #lose points and take damage
				Global.globalHealthPointsCurrent -= 1;
			else:   #noninput normal plate
				Global.scorePoints -= platePointValue * 0.5
				Global.platesFailed += 1
			Global.globalComboLossedHeat()
			queue_free();



	if area.is_in_group("Detector"):   #when the item is passing through the scanner
		acceptingInput = true;

	if area.is_in_group("Trash"):   #for when items can be thrown away
		if plateHeld == true:
			plateTrashing = true
			Global.platesTrashed += 1
			queue_free();
		if plateHeld == false:
			print("PLATE POSITION ERROR");

	if area.is_in_group("Tentacle"):   #when tentacle attacks
		if plateHeld == false:
			plateTrashing = true
			Global.scorePoints -= platePointValue * 0.5   #lose points
			queue_free();

func _on_food_area_area_exited(area):   #no longer accepting input at the last second
	if area.is_in_group("Detector"):
		acceptingInput = false;

func _on_food_area_mouse_entered():
	mouseOverObject = true;

func _on_food_area_mouse_exited():
	mouseOverObject = false;

func _input(event):   #checks input names to see if they match the item's description.
	if event.is_action_pressed("MouseClick") and mouseOverObject == true:
		if plateHeld == false:
			previousFoodPosition = position;   #storing the locatin of the food item before picked up
		plateHeldPosition = position
		plateHeld = true
		plateCollision.set_disabled(true)   #this prevents the item from flying at the camera
	if event.is_action_released("MouseClick") and plateHeld == true:
		plateHeld = false
		plateCollision.set_disabled(false)
		if plateTrashing == false:
			position = lerp(plateHeldPosition, previousFoodPosition, 0.01)   #unless we are throwing it away, we should return the item
