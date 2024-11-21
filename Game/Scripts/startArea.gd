extends Area2D

@onready var door_right: TileMapLayer = %DoorRight
@onready var door_bottom: TileMapLayer = %DoorBottom

func _ready() -> void:
	door_right.enabled = false
	door_bottom.enabled = true
	pass
func _on_body_exited(body: Node2D) -> void:
	door_right.enabled = true
	door_bottom.enabled = false
	pass

func unlockRightDoor():
	door_right.enabled = false
