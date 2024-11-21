extends Area2D

var isEnabled = true

@onready var resetButton = %ResetButton
#var test: bool = false
#
#func _on_body_entered(body):
	#if(!test):
		#GhostManager.startReplay()
		#GhostManager.startRecording()
		#test = !test
	#else:
		#GhostManager.endRecording()
		#GhostManager.stopReplay()
		#test = !test
	#pass # Replace with function body.
	
func _on_body_entered(body):
	if(isEnabled):
		print("Level Started")
		isEnabled = false
		GhostManager.startRecording()
		GhostManager.startReplay()
		Replay.setAreaToActivate(self)
		resetButton.setEnabled(true)
	pass
	
func setEnabled(isEnabled: bool):
	self.isEnabled = isEnabled
