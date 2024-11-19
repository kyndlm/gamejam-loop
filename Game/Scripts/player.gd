extends CharacterBody2D

@export var speed: float = 100.0
@onready var anim_player = $AnimatedSprite2D

enum State {
	IDLE,
	WALK,
	ATTACK
}

var current_state: State = State.IDLE
var last_direction: String = "down"

@export var attack_duration: float = 0.2
var attack_timer: float = 0.0
var is_attacking: bool = false

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

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

	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
			current_state = State.IDLE
	elif Input.is_action_just_pressed("attack"):
		current_state = State.ATTACK
		is_attacking = true
		attack_timer = attack_duration
	elif direction == Vector2.ZERO:
		current_state = State.IDLE
	else:
		current_state = State.WALK

	match current_state:
		State.IDLE:
			_handle_idle_state()
		State.WALK:
			_handle_walk_state(direction)
		State.ATTACK:
			_handle_attack_state()

	if current_state != State.ATTACK:
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

func _handle_attack_state() -> void:
	match last_direction:
		"down":
			anim_player.play("attack_down")
		"up":
			anim_player.play("attack_up")
		"side":
			anim_player.play("attack_side")
