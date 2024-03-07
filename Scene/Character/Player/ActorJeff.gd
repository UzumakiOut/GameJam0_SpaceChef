extends Node3D

var isDead = Global.spookyMode

func _process(delta):
	if Global.spookyMode == true:
		$SKM_Jeff.visible = false
		$SKM_JeffDead.visible = true
	if Global.spookyMode == false:
		$SKM_Jeff.visible = true
		$SKM_JeffDead.visible = false;
		
