extends Area2D

var isEnabled = true

@onready var door_right: TileMapLayer = %DoorRight
@onready var door_bottom: TileMapLayer = %DoorBottom

func _on_body_exited(body: Node2D) -> void:
	door_right.enabled = true
	door_bottom.enabled = false
	if(isEnabled):
		isEnabled = false
		GhostManager.startReplay()
		GhostManager.startRecording()
		Replay.setAreaToActivate(self)
	pass

func unlockRightDoor():
	door_right.enabled = false

func setEnabled(isEnabled: bool):
	self.isEnabled = isEnabled
