extends Button




func _on_pressed():
	$"../../../StartGameSound".play()
	SceneTransition.change_scene("res://GameplayStage.tscn");
