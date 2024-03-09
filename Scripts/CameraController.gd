extends Node3D

@onready var playerCamera = $Camera3D;
var cameraBobSpeedAndDirection = Vector3(0.0,0.01,0.0);
var cameraFollowSpeed = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
		playerCamera.position += cameraBobSpeedAndDirection;
		if playerCamera.position.y >= 0.1:
				cameraBobSpeedAndDirection =Vector3(0.0,-0.0001,0.0)
		if playerCamera.position.y <= -0.1:
				cameraBobSpeedAndDirection =Vector3(0.0,0.0001,0.0)
	
func _input(_event):
	if Input.is_action_pressed("MouseClick"):
		var mousePos = get_viewport().get_mouse_position()
		var mouseRayLength = 100
		var mouseRayStart = playerCamera.project_ray_origin(mousePos)
		var mouseRayEnd = mouseRayStart + playerCamera.project_ray_normal(mousePos) * mouseRayLength
		var mouseRayWorldSpace = get_world_3d().direct_space_state
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = mouseRayStart
		rayQuery.to = mouseRayEnd
		rayQuery.collide_with_areas = true
		rayQuery.collide_with_bodies = false
		var mouseRayResult = mouseRayWorldSpace.intersect_ray(rayQuery)
		Global.globalMouseLocationInSpace = mouseRayResult.position
		rayQuery.set_collision_mask(1)
		#print(Global.globalMouseLocationInSpace);
		
	if Input.is_action_just_released("MouseClick"):
		Global.globalMouseLocationInSpace = Vector3();

