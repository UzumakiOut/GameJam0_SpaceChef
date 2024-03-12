extends Node3D

@onready var Anim = $"../AnimationPlayer"
var isInactive = false;


func _ready():
	eyeballAnimationRepeater();



func eyeballAnimationRepeater():
	Anim.stop()
	if isInactive == false:
		Anim.play("ANIM_EyeAdjust")
		await get_tree().create_timer(13).timeout
		eyeballAnimationRepeater();
	else:
		Anim.stop()
