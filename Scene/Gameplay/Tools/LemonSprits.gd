extends Node3D

#references
@onready var spawnLocation = global_position
@onready var spritsArea = $SpritzerArea
@onready var spritsCollision = $SpritzerArea/CollisionShape3D
@onready var spritsHurtBox = $SprayHurtBox/CollisionShape3D
@onready var spritsVolume = $SM_Spritzer/FogVolume
@onready var spritsLight = $SM_Spritzer/SpotLight3D

#movement
var spritsHeldPosition = Vector3()
var spritsHeld = false
var mouseOverObject = false

#action
var isSpraying = false;

func _ready():
	pass



func _physics_process(_delta):
	if spritsHeld == true:
		position = lerp(position, Global.globalMouseLocationInSpace, 0.5);
	else:
		position = lerp(position, spawnLocation, 0.5);



func _on_spritzer_area_mouse_entered():
	mouseOverObject = true;


func _on_spritzer_area_mouse_exited():
	mouseOverObject = false;





func _input(event):
	if event.is_action_pressed("MouseClick") and mouseOverObject == true:
		if spritsHeld == false:
			spritsHeld = true
			spritsCollision.set_disabled(true);
	if event.is_action_released("MouseClick") and spritsHeld == true:
			spritsHeld = false
			spritsCollision.set_disabled(false)
			position = lerp(Global.globalMouseLocationInSpace, spawnLocation, 0.1)
	if event.is_action_pressed("RightMouseClick"):
		if spritsHeld == true:
			isSpraying = false
			$AnimationPlayer.stop()
			isSpraying = true
			spritsLight.visible = true
			spritsVolume.visible = true
			spritsHurtBox.set_disabled(false)
			$AnimationPlayer.play("Sprits");
			await get_tree().create_timer(0.1).timeout
			spritsVolume.visible = false
			spritsLight.visible = false
			await get_tree().create_timer(0.2).timeout
			isSpraying = false
			spritsHurtBox.set_disabled(true);



