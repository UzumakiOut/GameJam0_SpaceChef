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
var plateDirection = Vector3(0.0,0.0,0.01); #base speed between 1 and 9
var plateSpeed = clamp(Vector3(plateDirection) + (Vector3(0.0, 0.0, Global.globalDifficulty)) * Vector3(0.0,0.0,0.001), Vector3(0.0,0.0,0.01), Vector3(0.0,0.0,0.028));
var increasedSpeed = 1.0

#points and scoring
@export var plateIsEvil = false;
@export var plateIsTrash = false;
var platePointValue = 0





func _ready():
		initialRNGComboOnItem()
		$Plate/ComboButton1.arrowValue = plateComboArray[0];
		$Plate/ComboButton2.arrowValue = plateComboArray[1];
		$Plate/ComboButton3.arrowValue = plateComboArray[2]
		$Plate/ComboButton4.arrowValue = plateComboArray[3]
		$Plate/ComboButton5.arrowValue = plateComboArray[4]
		$Plate/ComboButton6.arrowValue = plateComboArray[5]
		$Plate/ComboButton7.arrowValue = plateComboArray[6]
		$Plate/ComboButton8.arrowValue = plateComboArray[7]
		$Plate/ComboButton9.arrowValue = plateComboArray[8];
	
		platePointValue = platePointMultiplier * (plateDifficulty * 10) * Global.globalDifficulty;
		if plateIsEvil == true: #evil plates are negative points
			platePointValue = platePointValue * -1;
		if plateIsTrash == true: #trash plates are negative points, but not as bad as evil
			platePointValue = (platePointValue * 0.5) * -1;


func initialRNGComboOnItem(): #RNG for the combo buttons as they appear on the food item
	if platePregenerated == false:
		var comboArrayIndex = 0
		var comboArrayCurrentValue = 0
		plateComboArray.resize(0) #clear array
		sequence.resize(0)
		if predeterminedComboSize == false:
			plateDifficulty = randi_range(3, clamp((3 + (Global.globalDifficulty * 0.5)), 5, 9)) #set array size
		plateComboArray.resize(1);
		for i in plateComboArray:
			comboArrayCurrentValue = randi_range(1, 5)
			plateComboArray.insert(comboArrayIndex, comboArrayCurrentValue) #set value at index between 1 and 5
			sequence.insert(comboArrayIndex, plateComboDict.find_key(comboArrayCurrentValue)) #sets sequence to associated value
			comboArrayIndex += 1; #this is at the end of each loop
			if comboArrayIndex == plateDifficulty: #this should break the loop at it's max index
				break
		plateComboArray.resize(plateDifficulty)
		plateComboArray.resize(9);
		print(plateComboArray);

#movement of the item
func _process(_delta):
	if plateHeld == false and plateTrashing == false:
		position += plateSpeed * increasedSpeed;
	else:
		position = lerp(position, Global.globalMouseLocationInSpace, 0.05); #moves the item to the mouse aimed location.





func _on_food_area_area_entered(area):
	#when the item is heading out to award the player
	if area.is_in_group("Expo"):
		if completedInput == true:
			Global.scorePoints += platePointValue
			print(Global.scorePoints)
			queue_free();
		else:
			if plateIsEvil == false:
				Global.scorePoints -= platePointValue
				Global.spookyValue += platePointValue #spooky value will drive spooky stuff
				if Global.scorePoints <= 0:
					Global.scorePoints = 0;
					print(Global.scorePoints)
			queue_free();
	
	#when the item is passing through the scanner
	if area.is_in_group("Detector"):
		acceptingInput = true;
	
	#for when items can be thrown away
	if area.is_in_group("Trash"):
		if plateHeld == true:
			plateTrashing = true
			print("i am trashing it")
			queue_free();
		if plateHeld == false:
			print("Shouldn't be here");
			
#no longer accepting input at the last second
func _on_food_area_area_exited(area):
	if area.is_in_group("Detector"):
		acceptingInput = false;
	
		
func _on_food_area_mouse_entered():
	mouseOverObject = true;
	
	
func _on_food_area_mouse_exited():
	mouseOverObject = false;
	
#checks input names to see if they match the item's description.
func _input(event):
	if acceptingInput == true:
		if event.is_action_pressed(sequence[sequenceIndex]):
			correctInput = true
			print(sequence[sequenceIndex])
			sequenceIndex += 1;
			if sequenceIndex == sequence.size():
				sequenceIndex = 0
				completedInput = true;
				acceptingInput = false;
				increasedSpeed = 10
	else:
		if event.is_action_pressed("MouseClick") and mouseOverObject == true:
			if plateHeld == false:
				previousFoodPosition = position; #storing the locatin of the food item before picked up
			plateHeldPosition = position
			plateHeld = true
			plateCollision.set_disabled(true) #this prevents the item from flying at the camera
		if event.is_action_released("MouseClick") and plateHeld == true:
			plateHeld = false
			plateCollision.set_disabled(false)
			if plateTrashing == false:
				position = lerp(plateHeldPosition, previousFoodPosition, 0.01) #unless we are throwing it away, we should return the item
				
			#Global.runSpookyMode(); oh how i'd love to run this when you mess up
				#I need to figure out how to make a failure case for this, right now you can just mash key and get through.

