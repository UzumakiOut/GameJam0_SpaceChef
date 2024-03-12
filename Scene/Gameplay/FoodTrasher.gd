extends Node3D

@onready var trashcanCollisionArea = $TrashArea
@onready var textTrash = $SM_Trashcan/TrashText

func _ready():
	if Global.globalDifficultySetting >= 3:
		textTrash.visible = false;


func _on_trash_area_area_entered(area):
	if area.is_in_group("FoodItem"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("TrashCanEating");
