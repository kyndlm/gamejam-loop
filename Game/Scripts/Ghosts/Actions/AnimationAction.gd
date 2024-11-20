extends Action

class_name AnimationAction

var anim_player
var anim_playerReverse: Node2D
var animation
var flip_h


func initAnim(ghost: Node2D, animation: String, flip_h: bool) -> AnimationAction: 
	super.init(ghost)
	self.animation = animation
	self.flip_h = flip_h
	anim_player = ghost.get_node("AnimatedSprite2D")
	
	return self

func execute() -> bool: 
	if(!super.execute()):
		return false
	anim_player.flip_h = self.flip_h
	anim_player.play(self.animation)
	return true

func executeReverse() -> bool: 
	super.executeReverse()
	anim_playerReverse.flip_h = self.flip_h
	anim_playerReverse.play(self.animation)
	return true
	
func setReverseExecutor(node: Node2D):
	super.setReverseExecutor(node)
	anim_playerReverse = node.get_node("AnimatedSprite2D")
	pass
