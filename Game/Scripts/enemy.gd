extends CharacterBody2D

var health := randi_range(2,5)
var player : Node2D
var speed := 151

func _ready():
	speed = 151 + 10 * get_parent().get_parent().level
	player = get_parent().get_parent().get_node("Player")
	set_as_top_level(true)
	get_parent().get_parent().enemy_list.append(self)

func _physics_process(delta):
	if player:
		var dir = (player.global_position - global_position).normalized()
		velocity = (dir * speed)
		move_and_slide()

func take_DMG():
	health -= 1
	if health <= 0:
		queue_free()
		get_parent().get_parent().enemy_list.erase(self)
		
