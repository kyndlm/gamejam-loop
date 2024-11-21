extends Area2D

var player_in_area: bool = false
var damage_interval: float = 1.0  # Damage interval (1 second)
var last_damage_time: float = 0.0  # Time when the last damage was applied
var area1: Area2D
func _physics_process(delta: float) -> void:
	# Check if player is in area and enough time has passed for the next damage
	if player_in_area and (Time.get_ticks_msec() / 1000.0 - last_damage_time >= damage_interval):
		GameManager.playerHit()  # Apply damage
		print("Damage applied")
		last_damage_time = Time.get_ticks_msec() / 1000.0  # Update the last damage time

func _on_area_entered(area: Area2D) -> void:
	area1 = area
	print(area)
	player_in_area = true


func _on_area_exited(area: Area2D) -> void:
	area1 = area
	player_in_area = false
