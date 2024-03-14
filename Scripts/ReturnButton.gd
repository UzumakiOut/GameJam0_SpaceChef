extends Button

func _on_pressed():
	$"../../../..".unpauseGame()
	SceneTransition.change_scene("res://MainMenu.tscn");
