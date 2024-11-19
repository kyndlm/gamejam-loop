extends Node

var actions: Array[Action] = []

var icon: Node2D
var player: Node2D

var startTime: int

var replayStart: int
var playReplay: bool

func _ready():
	startTime = Time.get_ticks_msec()
	icon = get_node("/root/Universe/World/Icon")
	player = get_node("/root/Universe/World/CharacterBody2D")
	playReplay = false
	print(startTime)
	pass

func _process(delta):
	if(!playReplay && startTime + 5000 < Time.get_ticks_msec()):
		print("AUTOREPLAY")
		print(startTime)
		playReplay = true
		replayStart = Time.get_ticks_msec()
	if(!playReplay):
		addAction(Action.new().init(player, player.global_position.x , player.global_position.y, startTime))
	else:
		#print(actions[0].getTimeStamp())
		if(actions.size() > 0 && actions.front().getTimeStamp() <= (Time.get_ticks_msec() - replayStart)):
			print(actions.front().getTimeStamp())
			actions.front().execute()
			actions.pop_front()

			
	pass

func addAction(action: Action) -> void:
	actions.append(action)
	pass

func startReplay() -> void:
	replayStart = Time.get_ticks_msec()
	
	pass

#func getReplay() -> Array:
#	return actions.copy()
