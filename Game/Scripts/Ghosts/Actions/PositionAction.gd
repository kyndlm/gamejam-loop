extends Action

class_name PositionAction

var posX: int
var posY: int


func initPos(ghost: Node2D, posX: int, posY: int) -> PositionAction:
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

func executeReverse() -> bool: 
	super.executeReverse()
	reverseExecutor.global_position.x = posX
	reverseExecutor.global_position.y = posY
	return true
