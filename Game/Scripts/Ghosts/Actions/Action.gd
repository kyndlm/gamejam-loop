extends Resource

class_name Action

var executer: Node2D #: node who did it (GHOST)
var reverseExecutor: Node2D #player to reverse
var timeStamp: int

#value for how many times it should be rerecorded
var remainingReplays: int = 3

func init(executer: Node2D) -> Action:
	self.executer = executer
	return self

func execute() -> bool: 
	if(remainingReplays <= 0): #if nothing remaining also prevent execute it
		return false
	remainingReplays -= 1
	return true
	
func executeReverse() -> bool: 
	#reverseExecutor.visible = true
	return true
	
func setTimeStamp(timeStamp: int) -> void:
	self.timeStamp = Time.get_ticks_msec() - timeStamp
	pass
func getTimeStamp() -> int:
	return timeStamp

func getRemainingReplays() -> int:
	return remainingReplays

func setExecutor(node: Node2D):
	self.executer = node
	pass

func setReverseExecutor(node: Node2D):
	self.reverseExecutor = node
	pass
