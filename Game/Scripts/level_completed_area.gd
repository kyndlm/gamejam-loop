extends Area2D
var isEnabled = false
func _on_body_entered(body):
	if(isEnabled):
		GhostManager.stopReplay()
		GhostManager.endRecording()
		Replay.reversePlay(body, self.global_position)
		isEnabled = false
	pass

func setEnabled(isEnabled: bool):
	self.isEnabled = isEnabled
