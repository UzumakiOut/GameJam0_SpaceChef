extends Node2D

var isPaused = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS;

func _input(event):
	if event.is_action_pressed("PauseButton"):
		if isPaused == false:
			pauseGame();
		else:
			unpauseGame();

func pauseGame():
	isPaused = true
	get_tree().paused = true;
	$Control.visible = true;
	
func unpauseGame():
	isPaused = false
	get_tree().paused = false;
	$Control.visible = false;
