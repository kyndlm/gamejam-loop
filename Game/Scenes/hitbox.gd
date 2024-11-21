extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "EnemyHurtArea":
		print("is of type character")
		#body.takeDamage(GameManager.getPlayerDamage())
