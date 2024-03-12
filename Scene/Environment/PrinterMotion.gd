extends Node3D

#difficulty variables
var printerTimerSpeed = Global.globalDifficultyTimer #determines the firing speed of the spawner
var printerFiringMode = Global.globalDifficulty + Global.globalHeatingUp #value used to determine which "playing" animation for cooking
var printerAnimationPlayRate = 1.0 + clamp((Global.globalDifficulty * 0.1), 0, 1.5) #speed of printer animations

#arrays containing pointers for items to spawn and the size of the arrays for spawn range.
var tutorialItemSpawn = ["res://Scene/Gameplay/FoodItems/FoodFood/Item_FoodTutorial.tscn", "res://Scene/Gameplay/FoodItems/Trash/Item_TrashTutorial.tscn"]
var printableFoodItems = ["res://Scene/Gameplay/FoodItems/FoodFood/Item_BagelBundle.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_BowlOfGreen.tscn",
"res://Scene/Gameplay/FoodItems/FoodFood/Item_BowlOfNoods.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_BowlOfStew.tscn",
"res://Scene/Gameplay/FoodItems/FoodFood/Item_BowlOfTomato.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_DonutAlone.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_DonutTriple.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_OnigiriAlone.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_OnigiriGiant.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_OnigiriPlatter.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_OnigiriTriple.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_PizzaChz.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_PizzaForce.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_PizzaGreen.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_PizzaPep.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_PizzaWhole.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_PotatoBaked.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_PotatoButtered.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_PotatoCheezed.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_PotatoIrishParty.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_SandwichAlone.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_SandwichDonutCombo.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_SandwichDouble.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_SandwichOniCombo.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_SandwichPotCombo.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_SteakDry.tscn", 
"res://Scene/Gameplay/FoodItems/FoodFood/Item_SteakRare.tscn", "res://Scene/Gameplay/FoodItems/FoodFood/Item_SteakTwoRare.tscn"]
var foodItemArrayLength = printableFoodItems.size();

var printableTrashItems = ["res://Scene/Gameplay/FoodItems/Trash/Item_Toothpaste.tscn", "res://Scene/Gameplay/FoodItems/Trash/Item_Lightbulbs.tscn", 
"res://Scene/Gameplay/FoodItems/Trash/Item_BatteriesSmall.tscn", "res://Scene/Gameplay/FoodItems/Trash/Item_BatteriesBig.tscn"]
var trashItemArrayLength = printableTrashItems.size();

var printableEvilItems = ["res://Scene/Gameplay/FoodItems/EvilFood/Item_BowlOfBlood.tscn","res://Scene/Gameplay/FoodItems/EvilFood/Item_BrainsLarge.tscn",
"res://Scene/Gameplay/FoodItems/EvilFood/Item_BrainsMultiple.tscn", "res://Scene/Gameplay/FoodItems/EvilFood/Item_BrainsNormal.tscn", 
"res://Scene/Gameplay/FoodItems/EvilFood/Item_Effigy.tscn", "res://Scene/Gameplay/FoodItems/EvilFood/Item_Eyeballs.tscn",
"res://Scene/Gameplay/FoodItems/EvilFood/Item_Foot.tscn", "res://Scene/Gameplay/FoodItems/EvilFood/Item_Hand.tscn", "res://Scene/Gameplay/FoodItems/EvilFood/Item_SteakEvil.tscn"]
var evilItemArrayLength = printableEvilItems.size();

#spawning
@onready var spawnFoodLocation = $FoodSpawnLocation.global_position;
var canSpawnFood = true
var isSpawningFood = false
var executionDelay = 0.5
var SpawnRNG = 10
var spawnTrashRNG1 = 1
var spawnTrashRNG2 = 2
var canSpawnTrash = false
var spawnEvilRNG1 = 3
var canSpawnEvil = false;



func _ready():
	Global.globalItemFoodSpawnLocation = spawnFoodLocation;

func _process(_delta):
	$AnimationPlayer.set_speed_scale(printerAnimationPlayRate)
	if canSpawnFood == true and isSpawningFood == false:
		spawningFoodItem()

func spawningFoodItem():
	isSpawningFood = true
	printerMoveDown()
	await get_tree().create_timer(executionDelay).timeout
	printerCook()
	await get_tree().create_timer(executionDelay).timeout
	spawnItemAtLocation();
	printerMoveUp()
	await get_tree().create_timer(executionDelay).timeout
	if canSpawnFood == true:
		spawningFoodItem()

#Animations
func printerMoveDown():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("printerMoveDown");
	executionDelay = 0.5
	
func printerCook():
	if printerFiringMode <= 5:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("printerCookingSlow");
		executionDelay = 1.2
	if printerFiringMode > 5 and printerFiringMode <= 10:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("printerCooking");
		executionDelay = 0.5
	if printerFiringMode >= 11:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("printerCookingFastest");
		executionDelay = 0.3
	
func printerMoveUp():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("printerMoveUp");
	executionDelay = 0.6


#spawning
func spawnItemAtLocation():
	#Determine if a food, trash, or evil
	SpawnRNG = randi_range(1, 20) #roll for initiative
	#print(SpawnRNG)
	var IndexRNG = 0
	var itemToBePrinted = "string"
	if SpawnRNG == spawnEvilRNG1: #chance for evil item
		IndexRNG = randi_range(0, (evilItemArrayLength - 1))
		itemToBePrinted = printableEvilItems[IndexRNG];
	if SpawnRNG == spawnTrashRNG1 or SpawnRNG == spawnTrashRNG2: #chance for trash
		IndexRNG = randi_range(0, (trashItemArrayLength - 1))
		itemToBePrinted = printableTrashItems[IndexRNG];
	if SpawnRNG != spawnEvilRNG1 and SpawnRNG != spawnTrashRNG1 and SpawnRNG != spawnTrashRNG2: #remainder is food
		IndexRNG = randi_range(0, (foodItemArrayLength - 1))
		itemToBePrinted = printableFoodItems[IndexRNG];
	var sceneFood = load(itemToBePrinted)
	var sceneInstanceFood = sceneFood.instantiate()
	sceneInstanceFood.position = spawnFoodLocation
	get_tree().get_root().add_child(sceneInstanceFood)
	
	#sceneInstanceFood.set_name("FoodItem")
	#add_child(sceneInstanceFood);








