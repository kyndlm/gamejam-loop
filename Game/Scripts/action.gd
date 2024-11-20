extends Resource

class_name Action

var executer: Node2D #: node who did it (GHOST)
var timeStamp: int

#value for how many times it should be rerecorded
var remainingReplays: int = 3

func init(executer: Node2D) -> Action:
	self.executer = executer
	return self

func execute() -> bool: 
	if(remainingReplays <= 0): #if nothing remaining also prevent execute it
		return false
	executer.visible = true	
	remainingReplays -= 1
	return true
	
func setTimeStamp(timeStamp: int) -> void:
	self.timeStamp = Time.get_ticks_msec() - timeStamp
	pass
func getTimeStamp() -> int:
	return timeStamp

func getRemainingReplays() -> int:
	return remainingReplays
