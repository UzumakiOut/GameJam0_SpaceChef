extends Button


func _on_pressed():
	$"..".visible = false
	$"../../PauseMenu".visible = true
	$"../../../ButtonSounds".play();
