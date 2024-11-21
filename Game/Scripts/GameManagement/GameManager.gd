extends Node

var level: int

#now vars for each room. Dont let him into new 
#room if not completed 
var enemiesLeft: int = 0
var spawnAreas: Array[SpawnArea] = []

enum Room {
	BASE,
	ONE,
	TWO,
	THREE
}

var current_room: Room = Room.BASE

func _ready():
	# get Spawn Areas
	for i in range(spawnAreas.size()):
		print("test dicker DAVID")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func startNewWave(player: Node2D):
	for sArea in spawnAreas:
		sArea.spawn_enemies(player, level*2 + 3)
		enemiesLeft += level*2+3
	
	pass

#only done if the last room is empty
func win_condition() -> int:
	return current_room if enemiesLeft == 0 else -1
	

func getLevel() -> int:
	return level

func registerSpawnArea(sArea: SpawnArea):
	self.spawnAreas.append(sArea)
	pass
