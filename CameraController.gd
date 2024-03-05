extends Node3D

@onready var Camera = $Camera3D;
var cameraBobSpeedAndDirection = Vector3(0.0,0.01,0.0);
var cameraFollowSpeed = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		Camera.position += cameraBobSpeedAndDirection;
		if Camera.position.y >= 0.05:
				cameraBobSpeedAndDirection =Vector3(0.0,-0.0001,0.0)
		if Camera.position.y <= -0.05:
				cameraBobSpeedAndDirection =Vector3(0.0,0.0001,0.0)
	
	

