extends Node


var scorePoints = 0
var scoreVictory = 10000
var spookyValue = 0
var spookyMode = false

func _process(delta):
	if spookyValue >= 200:
		spookyMode = true;
		runSpookyMode()

func runSpookyMode():
	spookyMode = true
	print(spookyMode)
	await get_tree().create_timer(0.5).timeout
	spookyValue = 0
	spookyMode = false
	print(spookyMode);
