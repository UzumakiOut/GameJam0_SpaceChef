extends Node3D

#exposed for editing purposes

@export var plateDifficulty = 3; #value from 1 - 9
@export var plateMovementRate = 1;
@export var platePointMultiplier = 1;

#right now these two related items are not grouped, i should look into this.
@export var plateComboArray = [4, 5, 2, 4, 5, 2, 5, 5, 5];  #for now this will always be 9 items
@export var sequence = ["RightArrow", "Spacebar", "DownArrow", "RightArrow", "Spacebar", "DownArrow", "Spacebar", "Spacebar", "Spacebar"];
var sequenceIndex = 0;
var acceptingInput = false;
var correctInput = false;
var completedInput = false;

var plateRandiValue = randi_range(90, 110);
var platePointValue = plateRandiValue * platePointMultiplier + (0.2 * (plateRandiValue * plateDifficulty));

var plateDirection = Vector3(0.0,0.0,0.005) * plateDifficulty; #base speed between 1 and 9
var plateSpeed = clamp(Vector3(plateDirection), Vector3(0.0,0.0,0.005), Vector3(0.0,0.0,0.05) );
var increasedSpeed = 1.0

func _ready():

#I guess i'm gonna be faking it, I'll find some way to randomly swap between a bunch of pregenerated button combos.
		$Plate/ComboButton1.arrowValue = plateComboArray[0];
		$Plate/ComboButton2.arrowValue = plateComboArray[1];
		$Plate/ComboButton3.arrowValue = plateComboArray[2];
		$Plate/ComboButton4.arrowValue = plateComboArray[3];
		$Plate/ComboButton5.arrowValue = plateComboArray[4];
		$Plate/ComboButton6.arrowValue = plateComboArray[5];
		$Plate/ComboButton7.arrowValue = plateComboArray[6];
		$Plate/ComboButton8.arrowValue = plateComboArray[7];
		$Plate/ComboButton9.arrowValue = plateComboArray[8];
	
#movement of the item

func _process(_delta):
	position += plateSpeed * increasedSpeed;





func _on_food_area_area_entered(area):
	#when the item is heading out to award the player
	if area.is_in_group("Expo"):
		if completedInput == true:
			print("Time to give points!");
			Global.scorePoints += platePointValue;
			print(Global.scorePoints);
		else:
			print("Penalize player now!");
			Global.scorePoints -= platePointValue;
			Global.spookyValue += platePointValue;
			print(Global.scorePoints);
	
	#when the item is passing through the scanner
	if area.is_in_group("Detector"):
		acceptingInput = true;
	
	#for when items can be thrown away
	if area.is_in_group("Trash"):
		print("I am throwing it away");

#no longer accepting input at the last second
func _on_food_area_area_exited(area):
	if area.is_in_group("Detector"):
		acceptingInput = false;

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
		#else:
			#Global.runSpookyMode(); oh how i'd love to run this when you mess up
				#I need to figure out how to make a failure case for this, right now you can just mash key and get through.
