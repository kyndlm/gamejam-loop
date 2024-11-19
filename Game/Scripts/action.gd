extends Resource

class_name Action

var executer: Node2D #: node who did it (GHOST)
var timeStamp: int


func init(executer: Node2D) -> Action:
	self.executer = executer
	return self

func execute() -> void: 
	executer.visible = true	
	pass
	
func setTimeStamp(timeStamp: int) -> void:
	self.timeStamp = Time.get_ticks_msec() - timeStamp
	pass
func getTimeStamp() -> int:
	return timeStamp
