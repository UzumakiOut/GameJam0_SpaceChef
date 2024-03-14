extends Button




func _on_pressed():
	$"..".visible = false
	$"../../MainMenu".visible = true
	$"../../../ButtonSounds".play();
