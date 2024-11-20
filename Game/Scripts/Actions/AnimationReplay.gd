extends Action

class_name AnimationReplay

var anim_player
var animation
var flip_h


func initAnim(ghost: Node2D, animation: String, flip_h: bool) -> AnimationReplay: 
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
