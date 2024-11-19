extends Node

# save position every tick and save it to replay it
# 

var startOfLevel

#test mause node


var queue = [] # saved is the class "action.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#addPos(mouse.x, mouse.y)
	pass
	
	#start of level taketimestamp
func levelStart():
	startOfLevel = Time.get_ticks_msec() # oder usec für mikro sekunden
	pass
	
func addPos(posx, posy):
	#here timestamp
	
	#currtimeinmillis - global Timestamp
	#save pos+timestamp in
	pass
