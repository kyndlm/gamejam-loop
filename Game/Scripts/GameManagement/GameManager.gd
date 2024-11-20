extends Node

var level: int

#now vars for each room. Dont let him into new 
#room if not completed 
var enemyLeft: int

enum Room {
	BASE,
	ONE,
	TWO,
	THREE
}

var current_room: Room = Room.BASE

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

#only done if the last room is empty
func win_condition() -> int:
	return current_room if enemyLeft == 0 else -1
	

func getLevel() -> int:
	return level

	
