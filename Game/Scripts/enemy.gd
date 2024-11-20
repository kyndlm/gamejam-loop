extends CharacterBody2D

@export var speed: float = 70
@export var attack_duration: float = 0.2
@export var attack_cooldown_duration: float = 0.5

@onready var anim_player = %EnemyAnimPlayer
@onready var player = %Player

enum State{
	IDLE,
	WALK,
	ATTACK}

var current_state: State = State.IDLE
var last_direction: String = "down"

var attack_timer: float = 0.0
var attack_cooldown_timer: float = 0.0
var is_attacking: bool = false

var direction: Vector2 = Vector2.ZERO

@export var detection_range: float = 100.0
@export var attack_range: float = 15.0

func _physics_process(delta):
	var distance_to_player = position.distance_to(player.position)
	
	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= delta

	if not is_attacking:
		if attack_cooldown_timer <= 0:
			if distance_to_player <= attack_range:
				current_state = State.ATTACK
				is_attacking = true
				attack_timer = attack_duration
			elif distance_to_player <= detection_range:
				current_state = State.WALK
				direction = (player.position - position).normalized()
			else:
				current_state = State.IDLE
		else:
			if distance_to_player <= detection_range:
				current_state = State.WALK
				direction = (player.position - position).normalized()
			else:
				current_state = State.IDLE

	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
			current_state = State.IDLE
			attack_cooldown_timer = attack_cooldown_duration

	match current_state:
		State.ATTACK:
			_handle_attack_state()
		State.IDLE:
			_handle_idle_state()
		State.WALK:
			_handle_walk_state(direction)
		
	if current_state == State.WALK:
		velocity = direction * speed
		move_and_slide()

func _handle_idle_state():
	match last_direction:
		"down":
			anim_player.play("idle_down")
		"up":
			anim_player.play("idle_up")
		"side":
			anim_player.play("idle_side")

func _handle_walk_state(direction: Vector2):
	var ddirection = dominant_direction(direction)
	if ddirection.x > 0:
		last_direction = "right"
		anim_player.flip_h = false
		anim_player.play("walk_side")
	elif ddirection.x < 0:
		last_direction = "left"
		anim_player.flip_h = true
		anim_player.play("walk_side")
	elif ddirection.y > 0:
		last_direction = "down"
		anim_player.play("walk_down")
	elif ddirection.y < 0:
		last_direction = "up"
		anim_player.play("walk_up")

func _handle_attack_state():
	match last_direction:
		"down":
			anim_player.play("attack_down")
		"up":
			anim_player.play("attack_up")
		"right":
			anim_player.play("attack_side")
		"left":
			anim_player.play("attack_side")

	if is_attacking and attack_timer <= attack_duration / 2:
		_perform_attack()
		
func dominant_direction(direction: Vector2) -> Vector2:
	if abs(direction.x) > abs(direction.y):
		return Vector2(sign(direction.x), 0)
	else:
		return Vector2(0, sign(direction.y))

func _perform_attack():
	if position.distance_to(player.position) <= attack_range:
		pass
