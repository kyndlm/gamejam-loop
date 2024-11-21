extends Node2D

var isEnabled = true

@onready var door_right: TileMapLayer = %DoorRight
@onready var door_bottom: TileMapLayer = %DoorBottom
@onready var reset_button: Node2D = %ResetButton

func unlockRightDoor():
	door_right.enabled = false
	door_bottom.enabled = true
	self.isEnabled = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	door_right.enabled = true
	door_bottom.enabled = false
	if(isEnabled):
		isEnabled = false
		GhostManager.startReplay()
		GhostManager.startRecording()
		Replay.setAreaToActivate(self)
		GameManager.startNewWave(body)
		reset_button.setEnabled(true)
	pass
