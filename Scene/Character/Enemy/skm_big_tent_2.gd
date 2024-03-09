extends Node3D
@onready var Anim = $AnimationPlayer
var isInactive = false;



# Called when the node enters the scene tree for the first time.
func _ready():
	tentacleAnimationRepeater();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func tentacleAnimationRepeater():
	Anim.stop()
	if isInactive == false:
		Anim.play("ANIM_TentIdle")
		await get_tree().create_timer(7.5).timeout
		tentacleAnimationRepeater();
	else:
		Anim.stop()
