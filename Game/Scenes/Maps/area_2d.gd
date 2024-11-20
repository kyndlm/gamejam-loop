extends Area2D



var tilemap

func _ready() -> void:
	tilemap = get_node("TileMapLayer")
	pass

func _on_body_exited(body: Node2D) -> void:
	tilemap.enabled = true
	pass

func unlockDoor():
	tilemap.genabled = false
