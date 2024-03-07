extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed("UpArrow"):
		print("UP");
	
	if event.is_action_pressed("DownArrow"):
		print("DOWN");

	if event.is_action_pressed("LeftArrow"):
		print("LEFT");

	if event.is_action_pressed("RightArrow"):
		print("RIGHT");
		
func _on_button_down(event):
	if event.is_action_pressed("MouseClick"):
		print("keydown");
	
func _on_button_up(event):
	if event.is_action_pressed("MouseClick"):
		print("keyup");
