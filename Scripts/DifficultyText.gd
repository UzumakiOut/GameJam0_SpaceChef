extends MeshInstance3D

func _ready():
	$".".mesh as TextMesh;

func _process(delta):
	if Global.globalDifficultySetting == 1:
		$".".set_text("<VERY EASY>");
	if Global.globalDifficultySetting == 2:
		$".".set_text("<VERY EASY>");
	if Global.globalDifficultySetting == 3:
		$".".set_text("<VERY EASY>");
	if Global.globalDifficultySetting == 4:
		$".".set_text("<VERY EASY>");
	if Global.globalDifficultySetting == 5:
		$".".set_text("<VERY EASY>");
