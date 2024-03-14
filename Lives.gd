extends HBoxContainer


@onready var lifeTextArray = [$Life, $Life2, $Life3];
var healthPoints = Global.globalHealthPointsCurrent


func _process(_delta):
	healthPoints = Global.globalHealthPointsCurrent
	if healthPoints == 1:
		$Life.visible = true;
		$Life2.visible = false;
		$Life3.visible = false;
		print("HP 1");
	elif healthPoints == 2:
		$Life.visible = true;
		$Life2.visible = true;
		$Life3.visible = false;
		print("HP 2");
	elif healthPoints == 3:
		$Life.visible = true;
		$Life2.visible = true;
		$Life3.visible = true;
		print("HP 3");
	else:
		$Life.visible = false;
		$Life2.visible = false;
		$Life3.visible = false;
