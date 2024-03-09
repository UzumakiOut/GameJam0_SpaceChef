extends Node3D

@onready var Anim = $"../AnimationPlayer"
var isInactive = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	eyeballAnimationRepeater();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func eyeballAnimationRepeater():
	Anim.stop()
	if isInactive == false:
		Anim.play("ANIM_EyeAdjust")
		await get_tree().create_timer(9).timeout
		eyeballAnimationRepeater();
	else:
		Anim.stop()
