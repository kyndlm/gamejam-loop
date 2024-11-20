extends Action

class_name PositionAction

var velocity


func initPos(ghost: Node2D, velocity: Vector2) -> PositionAction:
	super.init(ghost)
	self.velocity = velocity
	return self


func execute() -> bool: 
	if(!super.execute()):
		return false
	executer.visible = true	
	print(self.velocity)
	executer.velocity = self.velocity
	executer.move_and_slide()
	return true

func executeReverse() -> bool: 
	if(!super.executeReverse()):
		return false
	reverseExecutor.velocity = -(self.velocity)
	reverseExecutor.move_and_slide()
	return true
