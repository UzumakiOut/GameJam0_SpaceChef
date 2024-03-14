extends Button




func _on_pressed():
	$"../../../ButtonSounds".play()
	$"..".visible = false
	$"../../Settings".visible = true;
