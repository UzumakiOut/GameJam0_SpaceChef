extends Node3D

var motionSpeedAndDirection = Vector3(0.0, 0.0002, 0.0)
@onready var eyeball = $SKM_BigEye;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	eyeball.position += motionSpeedAndDirection;
	if eyeball.position.y >= 1:
			motionSpeedAndDirection =Vector3(0.0,-0.0002,0.0)
	if eyeball.position.y <= -1:
			motionSpeedAndDirection =Vector3(0.0,0.0002,0.0)

