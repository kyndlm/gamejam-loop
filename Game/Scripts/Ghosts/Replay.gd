extends Node

var actions: Array[Action] = []
var reverseActions: Array[Action] = []
var recordedActions: Array[Action] = []

var startTime: int

var player: Node2D

var replayStart: int
var reverseStart: int
var playReplay: bool

var isRecording: bool
var isReversing: bool

var endingPosition: Vector2

var areaToActivate: Node2D
	
func _ready():
	playReplay = false
	isRecording = false
	isReversing = false
	pass


func processGhost() -> void:
	if(playReplay):
		actionCheck()
	if(isReversing):
		reverseCheck()
	pass

func actionCheck():
	if(actions.size() > 0 && actions.front().getTimeStamp() <= (Time.get_ticks_msec() - replayStart)):
		if(actions.front().getRemainingReplays() > 0):
			actions.front().execute()
			recordedActions.append(actions.pop_front())
		else:
			actions.pop_front()
		actionCheck()
pass

func addAction(action: Action) -> void:
	recordedActions.append(action)
	reverseActions.append(action)
	action.setTimeStamp(startTime)
	pass
	
func reverseCheck():
	if(reverseStart == 0 && reverseActions.size() > 0):
		reverseStart = Time.get_ticks_msec() + reverseActions.front().getTimeStamp()/2
	if(reverseActions.size() <= 0):
		isReversing = false
		reverseStart = 0
		player.global_position = self.endingPosition
		GhostManager.getRecordingGhost().global_position = self.endingPosition
		GhostManager.getRecordingGhost().visible = true
		areaToActivate.setEnabled(true)
	if(reverseActions.size() > 0 && reverseActions.front().getTimeStamp()/2 >= reverseStart - Time.get_ticks_msec()):
		reverseActions.front().setReverseExecutor(player)
		reverseActions.front().executeReverse()
		reverseActions.pop_front()
		reverseCheck()
pass
	
func reversePlay(node: Node2D, endOnPosition: Vector2) -> void:
	self.player = node
	self.endingPosition = endOnPosition
	reverseActions.reverse()
	isReversing = true
	pass

func startReplay() -> void:
	replayStart = Time.get_ticks_msec()
	playReplay = true
	pass
	
func stopReplay() -> void:
	playReplay = false
	pass
	
func startedRecording():
	startTime = Time.get_ticks_msec()
	isRecording = true
	pass
	
func stoppedRecording():
	if(!isRecording): #if its not already recoding, then dont do anything
		return
	actions = recordedActions.duplicate()
	recordedActions = []
	isRecording = false
	pass

func setAreaToActivate(area: Node2D):
	self.areaToActivate = area