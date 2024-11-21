extends Action

class_name HitAction

var hitBoxDownScene = preload("res://Scenes/HitBoxDown.tscn")
var hitBoxUpScene = preload("res://Scenes/HitBoxUp.tscn")
var hitBoxRightScene = preload("res://Scenes/HitBoxRight.tscn")
var hitBoxLeftScene = preload("res://Scenes/HitBoxLeft.tscn")

var direction: String
var flip_h: bool
var pos: Vector2

@export var attack_duration: float = 0.2

func initHit(ghost: Node2D, pos: Vector2, direction: String, flipH: bool) -> HitAction:
	super.init(ghost)
	self.pos = pos
	self.direction = direction
	return self


func execute() -> bool: 
	super.execute()
	executer.global_position = pos
	var hitBox
	if direction == "down":
		hitBox = hitBoxDownScene.instantiate()
	if direction == "up":
		hitBox = hitBoxUpScene.instantiate()
	if direction == "side":
		if flip_h == false:
			hitBox = hitBoxRightScene.instantiate()
		else:
			hitBox = hitBoxLeftScene.instantiate()
	#hitBox.get_node("Area2D").global_position = pos
	self.executer.add_child(hitBox)
	await self.executer.get_tree().create_timer(attack_duration).timeout
	hitBox.queue_free()
	return true

func executeReverse() -> bool: 
	super.executeReverse()
	reverseExecutor.global_position = self.pos
	return true
