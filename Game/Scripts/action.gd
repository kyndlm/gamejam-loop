extends Resource

class_name Action

var executer: Node2D #: node who did it (GHOST)
var posX: int
var posY: int
var timeStamp: int


func init(executer: Node2D, posX: int, posY: int, startTimeStamp: int) -> Action:
	timeStamp = Time.get_ticks_msec() - startTimeStamp
	self.posX = posX
	self.posY = posY
	self.executer = executer
	print("action created  %s %s %s", [timeStamp, posX, posY])
	return self

func execute() -> void: 
	print("test")
	print("%s : %s -- %s" , [timeStamp, posX, posY])
	#executer.move(posx,posy)
	
	executer.global_position.x = posX
	executer.global_position.y = posY
	

	pass

func getTimeStamp() -> int:
	return timeStamp
