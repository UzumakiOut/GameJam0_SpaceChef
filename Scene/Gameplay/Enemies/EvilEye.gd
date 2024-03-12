extends Node3D

#refernces
@onready var eyeball = $SKM_BigEye
@onready var eyeCollision = $SKM_BigEye/EyeballCollision/CollisionShape3D

#editor variables
@export var difficultySpawnValue = 1 #between 1 and 5

#animation variables
var executionDelay = 0
var canRepeatIdle = true

#spawning varibles
var eyeballIsVisible = false
var eyeballCanSpawn = false
var eyeballSpawnChanceModifier = 0

#scoring
var canGiveSpookyValue = false

func _ready():
	$EyeballAnims.play("PreSpawnAnim")
	eyeball.visible = false
	eyeCollision.set_disabled(true)
	await get_tree().create_timer(0.1).timeout
	if Global.globalDifficultySetting >= difficultySpawnValue:
		regenerateEyeball();

func _process(_delta):
	if eyeballIsVisible == true:
		eyeballIsWatching();
	if eyeballCanSpawn == true:
			eyeballSpawnAnim();




func _on_eyeball_collision_area_entered(area):
	if area.is_in_group("Sprits"):
			Global.eyeballsSpritzed += 1
			eyeballGotJuiced();



func eyeballIsWatching():
	if canGiveSpookyValue == true:
		canGiveSpookyValue = false
		Global.spookyValue += 1 #increases spookyvalue until it is stopped
		await get_tree().create_timer(0.1).timeout
		canGiveSpookyValue = true;

func eyeballGotJuiced():
	if eyeballIsVisible == true:
		eyeballIsVisible = false
		canRepeatIdle = false
		Global.scorePoints += 10 * Global.globalDifficulty
		eyeballDeathAnim();
	


#animation player stuff
func eyeballSpawnAnim():
	eyeballCanSpawn = false #no need to do over mid spawning
	eyeballIsVisible = true
	canRepeatIdle = true
	eyeCollision.set_disabled(false)
	$EyeballAnims.stop()
	eyeball.visible = true
	executionDelay = 0.3
	$EyeballAnims.play("Spawning")
	await get_tree().create_timer(executionDelay).timeout
	canGiveSpookyValue = true
	eyeballIdleAnim();

func eyeballDeathAnim():
	$EyeballAnims.stop()
	$EyeballAnims.play("Sprits")
	canGiveSpookyValue = false
	executionDelay = 4
	await get_tree().create_timer(executionDelay).timeout
	eyeball.visible = false
	eyeCollision.set_disabled(true)
	regenerateEyeball();

func eyeballIdleAnim():
	$EyeballAnims.stop()
	$EyeballAnims.play("Idle")
	executionDelay = 4
	await get_tree().create_timer((executionDelay + randf_range(0.1, 0.3))).timeout
	if canRepeatIdle == true:
		eyeballIdleAnim();

func regenerateEyeball():
	await get_tree().create_timer(randi_range(30, (70 - Global.globalDifficulty))).timeout
	eyeballCanSpawn = true;
	
	
	
	
	
	
