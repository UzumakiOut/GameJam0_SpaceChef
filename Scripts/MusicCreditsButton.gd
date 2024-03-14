extends Button



func _on_pressed():
	$"..".visible = false
	$"../../Credits".visible = true
	$"../../../ButtonSounds".play();
