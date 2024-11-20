extends Action

class_name Position

var posX: int
var posY: int


func initPos(ghost: Node2D, posX: int, posY: int) -> Position:
	super.init(ghost)
	self.posX = posX
	self.posY = posY
	return self


func execute() -> bool: 
	if(!super.execute()):
		return false
	executer.global_position.x = posX
	executer.global_position.y = posY
	return true
