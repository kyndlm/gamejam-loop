extends Action

class_name TeleportAction

var pos


func initTp(ghost: Node2D, pos: Vector2) -> TeleportAction:
	super.init(ghost)
	self.pos = pos
	print("init pos ", pos)
	return self


func execute() -> bool: 
	super.execute()
	print("execute pos ", pos)
	executer.global_position = self.pos
	return true

func executeReverse() -> bool: 
	super.executeReverse()
	reverseExecutor.global_position = self.pos
	return true
