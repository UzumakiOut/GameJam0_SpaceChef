extends OptionButton



func _on_pressed():
	Global.globalDifficultySetting = get_selected_id() + 1
	$"../../../ButtonSounds".play();
