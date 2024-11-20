extends Area2D

# Variable to track if the door is open or closed
var is_open = false

func toggle_door():
	# Toggle the door's state
	is_open = !is_open
	$Sprite.visible = is_open  # Change visibility of the door sprite
