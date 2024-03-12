extends Node3D

#reference
@onready var bigTent = $Tent/SKM_BigTent
@onready var skinnyTent = $Tent/SKM_SkinnyTent
var activeTent = ""
@onready var Tent = $Tent
@onready var resetScale = Tent.scale


#editor values
@export var attackAnim = 1 #can be 1, 2, or 3
@export var tentSelect = 1 #1 is big, 2 is skinny
@export var difficultySpawnValue = 1 #between 1 and 5

#variables
var executionDelay = 0
var canSpawn = false
var tentHit = false
var tentAlive = false
var canGiveSpookyValue = false
var tentAggression = 0
var canAttack = false
var tentRunAwayValue = 0
var tentisBuildingAggro = true

func _ready():
	$AnimationPlayer.play("startAnim")
	if Global.globalDifficultySetting >= difficultySpawnValue:
		regenerateTent();


func _process(_delta):
	if tentAlive == true:
		tentTerror()
		tentAggroMeter();
		if tentRunAwayValue == 1 + Global.globalDifficultySetting:
			print("tent wore out")
			tentDeath();

func tentTerror():
	if canGiveSpookyValue == true:
		canGiveSpookyValue = false
		Global.spookyValue += 1 #increases spookyvalue until it is stopped
		await get_tree().create_timer(0.1).timeout
		canGiveSpookyValue = true;

func tentAggroMeter():
	if canAttack == false:
		if tentisBuildingAggro == true:
			tentisBuildingAggro = false
			await get_tree().create_timer(0.1).timeout
			tentAggression += 1
			tentisBuildingAggro = true;
		else:
			if tentAggression >= 20:
				canAttack = true
				tentAggression = 0
				tentacleAttack()
				await get_tree().create_timer(0.1).timeout
				canAttack = false;

func tentacleSelection():   #select tentacle size
	if tentSelect == 1:
		activeTent = bigTent
		skinnyTent.visible = false
		skinnyTent.scale = Vector3 (0.1, 0.1, 0.1);
		bigTent.scale = resetScale;
	else:
		activeTent = skinnyTent;
		bigTent.visible = false;
		bigTent.scale = Vector3 (0.1, 0.1, 0.1);
		skinnyTent.scale = resetScale;
	activeTent.animAttack = attackAnim;


func _on_area_3d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
		if area.is_in_group("Cleaver"):
			if tentHit == false:
				tentHit = true
				Global.scorePoints += 20 * Global.globalDifficulty
				Global.tentaclesChopped += 1
				tentDeath();


#animations
func tentacleAttack(): #play attack animation
	activeTent.tentAnimAttack()
	await get_tree().create_timer(1.6).timeout
	tentRunAwayValue += 1;

func tentSpawn():
	tentHit = false
	if canSpawn == true:
		canSpawn = false
		tentAlive = true
		tentAggression = 0
		tentRunAwayValue = 0
		activeTent.visible = true
		$AnimationPlayer.stop()
		$AnimationPlayer.play("SpawnAnim");

func tentDeath():
	tentAlive = false
	executionDelay = 1
	$AnimationPlayer.stop()
	$AnimationPlayer.play("DeathAnim")
	await get_tree().create_timer(executionDelay).timeout
	activeTent.visible = false
	regenerateTent();

func regenerateTent():
	await get_tree().create_timer(randi_range((30 - Global.globalDifficulty), (120 - (Global.globalDifficulty * 5)))).timeout
	tentSelect = randi_range(1,2)
	tentacleSelection()
	canSpawn = true
	tentSpawn();
