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

@onready var start_door: Node2D = null  # StartDoor-Referenz

func _ready():
	# Suche StartDoor in der aktuellen Szene
	if get_tree().current_scene:
		var world = get_tree().current_scene.get_node_or_null("World")
		if world:
			start_door = world.get_node_or_null("StartDoor")
	
	if start_door:
		print("StartDoor erfolgreich gefunden:", start_door)
	else:
		print("StartDoor konnte nicht gefunden werden.")
	
	playReplay = false
	isRecording = false
	isReversing = false

func processGhost() -> void:
	if playReplay:
		actionCheck()
	if isReversing:
		reverseCheck()

func actionCheck():
	if actions.size() > 0 and actions.front().getTimeStamp() <= (Time.get_ticks_msec() - replayStart):
		if actions.front().getRemainingReplays() > 0:
			actions.front().execute()
			recordedActions.append(actions.pop_front())
		else:
			actions.pop_front()
		actionCheck()

func addAction(action: Action) -> void:
	recordedActions.append(action)
	reverseActions.append(action)
	action.setTimeStamp(startTime)

func reverseCheck():
	if reverseStart == 0 and reverseActions.size() > 0:
		reverseStart = Time.get_ticks_msec() + reverseActions.front().getTimeStamp() / 2
	
	if reverseActions.size() <= 0:
		isReversing = false
		reverseStart = 0
		player.global_position = self.endingPosition
		if start_door:
			start_door.unlockRightDoor()  # Methode von StartDoor aufrufen
		else:
			print("StartDoor ist nicht gesetzt!")
		
	else:
		if reverseActions.front().getTimeStamp() / 2 >= reverseStart - Time.get_ticks_msec():
			reverseActions.front().setReverseExecutor(player)
			reverseActions.front().executeReverse()
			reverseActions.pop_front()
			reverseCheck()

func reversePlay(node: Node2D, endOnPosition: Vector2) -> void:
	self.player = node
	self.endingPosition = endOnPosition
	reverseActions.reverse()
	isReversing = true

func startReplay() -> void:
	print("Started Replay And set replayStart")
	print(actions.size())
	replayStart = Time.get_ticks_msec()
	playReplay = true

func stopReplay() -> void:
	print("stop Replay")
	playReplay = false

func startedRecording():
	print("start Recording")
	startTime = Time.get_ticks_msec()
	isRecording = true

func stoppedRecording():
	print("Stopped Recording")
	if not isRecording:  # if its not already recording, then don't do anything
		return
	while not actions.is_empty():
		recordedActions.append(actions.pop_front())
	actions = recordedActions.duplicate()
	recordedActions = []
	isRecording = false

func setAreaToActivate(area: Node2D):
	self.areaToActivate = area
