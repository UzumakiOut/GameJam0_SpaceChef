extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_expo_area_area_entered(area):
	if area.is_in_group("FoodItem"):
		$AnimationPlayer.play("expoEatingFood");
