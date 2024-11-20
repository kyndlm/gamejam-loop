extends Node

var player: Node2D
var ghostScene = preload("res://Scenes/Player/Ghost.tscn")
var ghosts = []
var currentGhostIndex = 0

var timedPassed = 0
var level = 0

var shouldRecordActions: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(3):
		var worldNode = get_node("/root/Universe/World")
		var ghost = ghostScene.instantiate()
		worldNode.add_child(ghost)
		ghost.visible = false
		self.ghosts.append(ghost)
	pass # Replace with function body.
	
func startRecording():
	shouldRecordActions = true
	Replay.startedRecording()
	pass
	
func endRecording():
	shouldRecordActions = false
	Replay.stoppedRecording()
	setNewGhost()
	pass
	
func setNewGhost():
	self.currentGhostIndex += 1
	if(self.currentGhostIndex == 3):
		self.currentGhostIndex = 0
	pass
	
func getRecordingGhost():
	return self.ghosts[self.currentGhostIndex]
	
func startReplay():
	Replay.startReplay()
	pass
	
func stopReplay():
	Replay.stopReplay()
	pass
	
func positionChanged(pos: Vector2):
	
	if(shouldRecordActions):
		Replay.addAction(PositionAction.new().initPos(getRecordingGhost(), pos.x, pos.y))
	pass
	
func animationChanged(animationName: String, flipped: bool):
	if(shouldRecordActions):
		Replay.addAction(AnimationAction.new().initAnim(getRecordingGhost(), animationName, flipped))
	pass
