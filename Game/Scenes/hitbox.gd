extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "EnemyHurtArea":
		#print("is of type character")
		#body.takeDamage(GameManager.getPlayerDamage())
		#enemy will get hurt, get parent of area thats the enemy
		area.get_parent().takeDamage()
