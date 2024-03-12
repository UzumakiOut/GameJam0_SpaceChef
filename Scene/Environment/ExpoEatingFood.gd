extends MeshInstance3D



func _on_expo_area_area_entered(area):
	if area.is_in_group("FoodItem"):
		$AnimationPlayer.play("expoEatingFood");
