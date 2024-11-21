extends CharacterBody2D

@export var speed: float = 100.0
@onready var anim_player = $AnimatedSprite2D

var hitBoxDownScene = preload("res://Scenes/HitBoxDown.tscn")
var hitBoxUpScene = preload("res://Scenes/HitBoxUp.tscn")
var hitBoxRightScene = preload("res://Scenes/HitBoxRight.tscn")
var hitBoxLeftScene = preload("res://Scenes/HitBoxLeft.tscn")

var positionFrameTime = 1
var passedTime = 0


@export var max_health: int = 100
@export var health: int = max_health
@export var attack: int = 25
@export var lvl: int = 1
@export var exp: float = 0.0
@export var exp_until_lvlup: float = 10.0

var attackCooldown: float = 0.4  # Dauer des Cooldowns
var attackCooldownTimer: float = 0.0  # Timer zur Verfolgung

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

func _ready():
	GhostManager.setPlayer(self)	

func _physics_process(delta: float) -> void:
	# Cooldown-Timer aktualisieren
	if attackCooldownTimer > 0:
		attackCooldownTimer -= delta

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

	# Angriff nur starten, wenn Cooldown abgelaufen ist
	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
			current_state = State.IDLE
	elif Input.is_action_just_pressed("attack") and attackCooldownTimer <= 0:
		current_state = State.ATTACK
		is_attacking = true
		attack_timer = attack_duration
		attackCooldownTimer = attackCooldown  # Cooldown setzen
		spawnHitBox(last_direction)
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
		GhostManager.positionChanged(velocity)
		passedTime += delta
		if passedTime > positionFrameTime:
			GhostManager.absolutePositionChanged(self.global_position)
	Replay.processGhost()

func _handle_idle_state() -> void:
	match last_direction:
		"down":
			anim_player.play("idle_down")
		"up":
			anim_player.play("idle_up")
		"side":
			anim_player.play("idle_side")
	GhostManager.animationChanged("idle_" + last_direction, anim_player.flip_h)

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
	GhostManager.animationChanged("walk_" + last_direction, anim_player.flip_h)

func _handle_attack_state() -> void:
	match last_direction:
		"down":
			anim_player.play("attack_down")
		"up":
			anim_player.play("attack_up")
		"side":
			anim_player.play("attack_side")
	GhostManager.animationChanged("attack_" + last_direction, anim_player.flip_h)

func spawnHitBox(state: String):
	# Hitbox instanziieren
	var hitBox
	if state == "down":
		hitBox = hitBoxDownScene.instantiate()
	if state == "up":
		hitBox = hitBoxUpScene.instantiate()
	if state == "side":
		if anim_player.flip_h == false:
			hitBox = hitBoxRightScene.instantiate()
		else:
			hitBox = hitBoxLeftScene.instantiate()
	add_child(hitBox)
	await get_tree().create_timer(attack_duration).timeout
	hitBox.queue_free()
	pass
	
func get_health() -> int:
	return health
	
func get_maxHealth() -> int:
	return max_health
	
func get_attack() -> int:
	return attack
func get_lvl() -> int:
	return lvl
func get_exp() -> float:
	return exp
	
func get_exp_until_lvlup() -> float:
	return exp_until_lvlup
	
func set_health(new_health: int):
	health = new_health
func lvl_up_player():
	lvl += 1
	max_health += 15
	health = max_health
	attack += 5
	exp -= exp_until_lvlup
