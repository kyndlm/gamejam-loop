extends CharacterBody2D

@export var speed: float = 100.0

#animated_sprite ref
@onready var anim_player = $AnimatedSprite2D

enum State {
	IDLE,
	WALK
}

var ghost: Node2D

var current_state: State = State.IDLE
var last_direction: String = "down"

func _ready():
	ghost = load("res://Scenes/Player/Ghost.tscn").instantiate()
	get_parent().add_child(ghost)
	ghost = get_node("/root/Universe/World/CharacterBody2D2")
	pass

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	Replay.addAction(Action.new().init(ghost, self.global_position.x , self.global_position.y))

	# Detect input for movement
	if Input.is_action_pressed("right"):
		direction.x += 1
		anim_player.flip_h = false
	if Input.is_action_pressed("left"):
		direction.x -= 1
		anim_player.flip_h = true
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	
	direction = direction.normalized()

	#Update state:
	if direction == Vector2.ZERO:
		current_state = State.IDLE
	else:
		current_state = State.WALK
		
	match current_state:
		State.IDLE:
			_handle_idle_state()
		State.WALK:
			_handle_walk_state(direction)
		
	velocity = direction * speed
	move_and_slide()
	
func _handle_idle_state() -> void:
	match last_direction:
		"down":
			anim_player.play("idle_down")
		"up":
			anim_player.play("idle_up")
		"side":
			anim_player.play("idle_side")
			
func _handle_walk_state(direction: Vector2) -> void:
	if direction.y > 0:
		last_direction = "down"
		anim_player.play("walk_down")
	elif direction.y < 0:
		last_direction = "up"
		anim_player.play("walk_up")
	else:
		last_direction = "side"
		anim_player.play("walk_side")
