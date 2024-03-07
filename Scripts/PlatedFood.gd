extends Node3D

#exposed for editing
@export var plateSpeed = Vector3(0.0,0.0,1);
@export var plateBaseValue = randi_range(75, 150);
@export var plateComboArray = [1, 2, 3]; #This should have no more than 6 inputs
#0 = no input, 1 = up, 2 = down, 3 = left, 4 = right, 5 = ?

var plateDifficulty = 5 #This shouldn't go over 5
#variables to change down the road



# Called when the node enters the scene tree for the first time.
func _ready():
	var plateFinalValue = int(plateBaseValue * plateDifficulty + (clamp(len(plateComboArray), 1, 4) * 5));
	print(plateFinalValue);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (plateDifficulty * 1.5) * plateSpeed * delta;
