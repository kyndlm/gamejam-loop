extends Node

var actions: Array[Action] = []
var recordedActions: Array[Action] = []

var icon: Node2D
var player: Node2D

var startTime: int

var replayStart: int
var playReplay: bool

func _ready():
	icon = get_node("/root/Universe/World/Icon")
	player = get_node("/root/Universe/World/CharacterBody2D")
	playReplay = false
	pass

func _process(delta):
	if(playReplay):
		actionCheck()
	pass

func actionCheck():
	if(actions.size() > 0 && actions.front().getTimeStamp() <= (Time.get_ticks_msec() - replayStart)):
		actions.front().execute()
		recordedActions.append(actions.pop_front())
		actionCheck()
pass

func addAction(action: Action) -> void:
	recordedActions.append(action)
	action.setTimeStamp(startTime)
	pass

func startReplay() -> void:
	print("Start Replay")
	replayStart = Time.get_ticks_msec()
	playReplay = true
	pass
	
func stopReplay() -> void:
	print("Stop Replay")
	playReplay = false
	pass
	
func startedRecording():
	print("Started Recording (Set StartTime for Actions)")
	startTime = Time.get_ticks_msec()
	pass
	
func stoppedRecording():
	print("Stopped Recording")
	actions = recordedActions.duplicate()
	if(actions == recordedActions):
		print("Recoding saved")
	recordedActions = []
	pass
