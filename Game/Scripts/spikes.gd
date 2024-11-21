extends Area2D

var player_in_area: bool = false

func _physics_process(delta: float) -> void:
	if player_in_area == true:
		GameManager.playerHit()
		print("damage")
		await get_tree().create_timer(50).timeout


func _on_area_entered(area: Area2D) -> void:
	player_in_area = true


func _on_area_exited(area: Area2D) -> void:
	player_in_area = false
