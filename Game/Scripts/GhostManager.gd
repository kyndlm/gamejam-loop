extends Node

var player: Node2D
var ghostScene = preload("res://Scenes/Player/Ghost.tscn")
var ghosts = []
var currentGhostIndex = 0

var timedPassed = 0
var level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(3):
		var worldNode = get_node("/root/Universe/World")
		var ghost = ghostScene.instantiate()
		worldNode.add_child(ghost)
		#ghost.visible = false
		self.ghosts.append(ghost)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func endRecording():
	print("End Recording")
	Replay.stoppedRecording()
	self.currentGhostIndex += 1
	#Replay.stopReplay()
	pass
	
func getNextGhost(player: Node2D) -> Node2D:
	print("Get Next Ghost")
	Replay.startedRecording()
	return self.ghosts[self.currentGhostIndex]
	pass
	
func startReplay():
	Replay.startReplay()
	pass
	
func stopReplay():
	Replay.stopReplay()
	pass
