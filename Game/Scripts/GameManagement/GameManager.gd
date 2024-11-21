extends Node

var ui: Ui

var level: int = 1

var health: int = 100
var skillPoints = 0
var score: int = 0

#now vars for each room. Dont let him into new 
#room if not completed 
var enemiesLeft: int = 0
var spawnAreas: Array[SpawnArea] = []
var player: Node2D

enum Room {
	BASE,
	ONE,
	TWO,
	THREE
}

var current_room: Room = Room.BASE

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func startNewWave(player: Node2D):
	for sArea in spawnAreas:
		sArea.spawn_enemies(player, level*2 + 3)
		enemiesLeft += level*2+3
	
	pass

#only done if the last room is empty #not used rn
func win_condition() -> int:
	return current_room if enemiesLeft == 0 else -1
	

func registerSpawnArea(sArea: SpawnArea):
	self.spawnAreas.append(sArea)
	pass
	
func playerHit():
	health -= 1 + level*2
	player.damageAnimation()
	if(health <= 0):
		get_tree().quit()
	ui.setHealthBarValue(health)
	pass
	
func enemyKilled():
	player.add_exp(1)
	setLevelBar(player.get_lvl())
	pass
func enemyKilledLevelMult():
	score += level+1
	pass

func levelCompleted():
	level += 1
	#every second level you will get an additional skillpoint every level
	skillPoints += level/2+1 
	pass

func removeAllEnemys():
	for sArea in spawnAreas:
		sArea.removeAllEnemys()
	pass
	
#-GETTER:

func getLevel() -> int:
	return level

func getHealth() -> int:
	return health

func getScore() -> int:
	return score

func getSkillPoints() -> int:
	return skillPoints

func registerUi(ui: Ui):
	self.ui = ui
	pass
func setLevelBar(value: int):
	ui.setLevelBarValue(str(value))
	pass

func registerPlayer(player: Node2D):
	self.player = player
	setLevelBar(player.get_lvl())
	pass
	
func resetHealth():
	health = 100
	ui.setHealthBarValue(health)
	pass
