extends Label

var comboValue = Global.globalHeatingUp

func _ready():
	$".".visible = false;


func _process(_delta):
	comboValue = Global.globalHeatingUp
	if comboValue != 0:
		$".".visible = true;
		self.text = "_COMBO(x" + str(comboValue) + "):"
	else:
		$".".visible = false;
	if Global.globalHeat == true:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("HeatingUp");
