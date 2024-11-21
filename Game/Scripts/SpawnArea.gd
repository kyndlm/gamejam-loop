extends Node2D  # Für 2D; bei 3D `Node3D` verwenden

class_name SpawnArea

@export var enemy_scene: PackedScene  # Gegner-Szene
@export var spawn_area_size: Vector2 = Vector2(50, 50)  # Größe des Bereichs

var enemyList: Array[Node2D]

func _ready():
	GameManager.registerSpawnArea(self)
	pass

func spawn_enemies(player: CharacterBody2D, spawn_count: int):
	# Schleife, um Gegner zu spawnen
	for i in spawn_count:
		var enemy = enemy_scene.instantiate()  # Gegner-Szene instanziieren
		enemy.player = player
		var random_position = Vector2(
			randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2),
			randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
		)
		enemy.position = random_position
		enemyList.append(enemy)
		add_child(enemy)  # Gegner zur Szene hinzufügen

func removeAllEnemys():
	for e in enemyList:
		if(e != null && !e.is_queued_for_deletion()):
			e.queue_free()
