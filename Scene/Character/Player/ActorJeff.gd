extends Node3D

var isDead = Global.spookyMode
@export var jeffMainMenu = false
var mouseOverObject = false

func _ready():
	$SKM_Jeff.jeffMainMenu = jeffMainMenu
	$SKM_JeffDead.jeffMainMenu = jeffMainMenu
	
func _process(_delta):
	if Global.spookyMode == true:
		$SKM_Jeff.visible = false
		$SKM_JeffDead.visible = true
	if Global.spookyMode == false:
		$SKM_Jeff.visible = true
		$SKM_JeffDead.visible = false;


func _on_jeff_collision_mouse_entered():
	if jeffMainMenu == true:
		mouseOverObject = true;


func _on_jeff_collision_mouse_exited():
	if jeffMainMenu == true:
		mouseOverObject = false;

func _input(event):
	if event.is_action_pressed("MouseClick") and mouseOverObject == true:
		pass
