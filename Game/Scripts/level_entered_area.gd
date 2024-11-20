extends Area2D

var isEnabled = true
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
		isEnabled = false
		GhostManager.startReplay()
		GhostManager.startRecording()
		Replay.setAreaToActivate(self)
		get_parent().get_node("LevelCompletedArea").setEnabled(true)
	pass
	
func setEnabled(isEnabled: bool):
	self.isEnabled = isEnabled