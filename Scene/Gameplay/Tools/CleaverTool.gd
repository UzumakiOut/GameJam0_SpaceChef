extends Node3D

var cleaverHeld = false
var mouseOverObject = false
@onready var spawnLocation = global_position
var cleaverHeldPosition = Vector3()
@onready var cleaverArea = $CleaverArea
@onready var cleaverCollision = $CleaverArea/CollisionShape3D
@onready var cleaverHurtBox = $SM_Cleaver2/CleaverHurtBox/CollisionShape3D
var isSwinging = false;


func _ready():
	pass



func _physics_process(_delta):
	if cleaverHeld == true:
		position = lerp(position, Global.globalMouseLocationInSpace, 0.5);
	else:
		position = lerp(position, spawnLocation, 0.5);



func _on_cleaver_area_mouse_entered():
	mouseOverObject = true;


func _on_cleaver_area_mouse_exited():
	mouseOverObject = false;




func _input(event):
	if event.is_action_pressed("MouseClick") and mouseOverObject == true:
		if cleaverHeld == false:
			cleaverHeld = true
			cleaverCollision.set_disabled(true);
	if event.is_action_released("MouseClick") and cleaverHeld == true:
			cleaverHeld = false
			cleaverCollision.set_disabled(false)
			position = lerp(Global.globalMouseLocationInSpace, spawnLocation, 0.01)
	if event.is_action_pressed("RightMouseClick"):
		if cleaverHeld == true:
			isSwinging = false
			var randomSwing = randi_range(1, 3)   #might add more in later
			$AnimationPlayer.stop()
			isSwinging = true
			cleaverHurtBox.set_disabled(false)
			if randomSwing == 1:
				$AnimationPlayer.play("Swing2");
			elif randomSwing == 2:
				$AnimationPlayer.play("Swing2");
			elif randomSwing == 3:
				$AnimationPlayer.play("Swing3");
			await get_tree().create_timer(0.3).timeout
			isSwinging = false
			cleaverHurtBox.set_disabled(true);
