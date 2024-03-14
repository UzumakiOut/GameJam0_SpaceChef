extends Node

#obvious
var scorePoints = 0

#record keeping
var platesCompleted = 0
var platesFailed = 0
var platesTrashed = 0
var platesCursedAccepted = 0
var platesTrashAccepted = 0
var eyeballsSpritzed = 0
var tentaclesChopped = 0

#silly little guy
var spookyValue = 0
var spookyMode = true
var globalHealthPointsMax = 3
var globalHealthPointsCurrent = 3
var globalisDead = false
var globalHeat = false

#in-game clock
var gameplayTimerActive = true #set to true when gameplay "starts"
var gameTimerHours = 0 #the game will play for 6 "hours"
var gameTimerMinutes = 0 #every 60 minutes = one hour
var gameTimerSeconds = 0 #every 60 seconds = one minute

#difficulty stuff
var globalDifficultyEndlessMode = true #maybe
var globalDifficultySetting = 3 #Range from 1 to 5 "Very Easy, Easy, Normal, Hard, Very Hard"
var globalDifficultyTimer = 1 #this will be ticked up by the timer, then lowered at some point.
var globalDifficulty = globalDifficultySetting + globalDifficultyTimer #this changes based on factors here
var globalHeatingUp = 0 #increases speed after X consecutive combos


#stuff i am passing poorly
var globalMouseLocationInSpace = Vector3()

#gameplay stuff
var canSpawnFoodItem = true
var globalItemFoodSpawnLocation = Vector3()
var runTutorial = true


func _ready():
	resetGameplayGlobalValues();

func _process(_delta):
	roundi(scorePoints)
	gameplayWorkDayTimer();
	if scorePoints <= 0: #if points are less than 0, then they are 0
		scorePoints = 0;
	if spookyValue <= 0:
		spookyValue = 0;
	if spookyValue >= 500:
		runSpookyMode();
	else:
		spookyMode = false;


func resetGameplayGlobalValues():   #called when a game starts, resets all global variables that pertain to gameplay
	globalDifficultyTimer = 1
	globalHeatingUp = 0
	gameTimerHours = 0
	gameTimerMinutes = 0
	gameTimerSeconds = 0
	globalHealthPointsCurrent = 3
	platesCompleted = 0
	platesFailed = 0
	platesTrashed = 0
	platesCursedAccepted = 0
	platesTrashAccepted = 0
	eyeballsSpritzed = 0
	tentaclesChopped = 0
	scorePoints = 0
	spookyValue = 0
	spookyMode = false
	globalisDead = false

func setLeaderboard():
	pass #this may be added later on, but now now i'm not going to use it.

func addToLeaderboard():
	pass





func runSpookyMode():
	spookyMode = true;

func gameplayWorkDayTimer():
	gameplayTimerDifficultyChanges();
	if gameplayTimerActive == true:
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



func globalComboHeatingUp():
	globalHeat = true
	globalHeatingUp += 1
	await get_tree().create_timer(0.01).timeout
	globalHeat = false;

func globalComboLossedHeat():
	globalHeatingUp = 0;

