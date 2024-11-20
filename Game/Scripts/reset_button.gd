extends Node2D

@onready var player = $Player
@onready var buttonSprite = %ResetButtonSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body == player:
		buttonSprite.play("button_pressed")
		
		
func _on_area_2d_body_exited(body):
	buttonSprite.play("button_default")