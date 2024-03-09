extends Node

#obvious
var scorePoints = 0
var scoreVictory = 10000

#silly little guy
var spookyValue = 0
var spookyMode = false

#in-game clock
var gameplayTimerActive = true #set to true when gameplay "starts"
var gameTimerHours = 0 #the game will play for 6 "hours"
var gameTimerMinutes = 0 #every 60 minutes = one hour
var gameTimerSeconds = 0 #every 60 seconds = one minute

#difficulty stuff
var globalDifficultyEndlessMode = true #maybe
var globalDifficultySetting = 5 #Range from 1 to 5 "Very Easy, Easy, Normal, Hard, Very Hard"
var globalDifficultyTimer = 10 #this will be ticked up by the timer, then lowered at some point.
var globalDifficulty = globalDifficultySetting + globalDifficultyTimer #this changes based on factors here

#stuff i am passing poorly
var globalMouseLocationInSpace = Vector3()

#gameplay stuff
var canSpawnFoodItem = true

func _process(_delta):
	gameplayWorkDayTimer();
	if spookyValue >= 200:
		spookyMode = true
		runSpookyMode()

func runSpookyMode():
	spookyMode = true
	#print(spookyMode)
	await get_tree().create_timer(0.5).timeout
	spookyValue = 0
	spookyMode = false
	#print(spookyMode);

func gameplayWorkDayTimer():
	gameplayTimerDifficultyChanges();
	if gameplayTimerActive == true:
		#print("0",gameTimerHours,":", gameTimerMinutes,":", gameTimerSeconds);
		gameTimerSeconds += 1;
		if gameTimerSeconds == 60:
			gameTimerSeconds = 0
			gameTimerMinutes += 1;
			if gameTimerMinutes == 60:
				gameTimerMinutes = 0
				gameTimerHours += 1; #at 8 this should be where the normal gameplay loop ends
			
	
	#here's where it gets trashy
func gameplayTimerDifficultyChanges():
	var _globalDailyModifier = 1 #on specific days this will increase
	if globalDifficultyEndlessMode == false:
		if gameTimerHours == 1: #Early build up!
			globalDifficultyTimer = 3;
		if gameTimerHours == 2:
			globalDifficultyTimer = 2;
		if gameTimerHours == 3: #lunch coming in!
			globalDifficultyTimer = 4;
		if gameTimerHours == 4:
			globalDifficultyTimer = 3;
		if gameTimerHours == 5: #dinner rush
			globalDifficultyTimer = 8;
		if gameTimerHours == 7: #slows down at the end of the day
			globalDifficultyTimer = 2;
	else:
		if gameTimerMinutes == 59 and gameTimerSeconds == 59: #endless mode gets the ball rolling slower, but it's endless
			globalDifficultyTimer *= 1.5
			clamp(globalDifficultyTimer, 1, 10); #this caps the timer difficulty at around 5 minutes of gameplay
