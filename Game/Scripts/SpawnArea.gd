extends Node2D  # Für 2D; bei 3D `Node3D` verwenden

@export var enemy_scene: PackedScene  # Gegner-Szene
@export var spawn_area_size: Vector2 = Vector2(50, 50)  # Größe des Bereichs


func spawn_enemies(player: CharacterBody2D, spawn_count: int):
	# Schleife, um Gegner zu spawnen
	for i in spawn_count:
		var enemy = enemy_scene.instantiate()  # Gegner-Szene instanziieren
		var random_position = Vector2(
			randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2),
			randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
		)
		enemy.position = random_position
		enemy.player = player
		add_child(enemy)  # Gegner zur Szene hinzufügen
