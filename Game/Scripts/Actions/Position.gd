extends Action

class_name Position

var posX: int
var posY: int


func initPos(ghost: Node2D, posX: int, posY: int) -> Position:
	super.init(ghost)
	self.posX = posX
	self.posY = posY
	print("action created  %s %s %s", [timeStamp, posX, posY])
	return self


func execute() -> void: 
	executer.visible = true	
	executer.global_position.x = posX
	executer.global_position.y = posY
	pass
