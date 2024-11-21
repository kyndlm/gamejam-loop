extends Node2D

var isEnabled: bool = false

@onready var anim_player = %ResetButtonSprite

func _on_area_2d_body_exited(body):
	await get_tree().create_timer(0.3).timeout
	anim_player.play("button_default")
	
func _on_area_2d_body_entered(body):
	anim_player.play("button_pressed")
	if(isEnabled):
		GhostManager.stopReplay()
		GhostManager.endRecording()
		Replay.reversePlay(body, self.global_position)
		isEnabled = false
		
	pass

func setEnabled(isEnabled: bool):
	self.isEnabled = isEnabled
