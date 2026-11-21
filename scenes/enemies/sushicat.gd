class_name SushiCat extends Enemy

@export var animation_player : AnimationPlayer
@export var edge_dectection : RayCast2D
@export var wall_dectection : RayCast2D
@onready var jump_timer: Timer = $JumpTimer
@onready var bullet = preload("res://scenes/enemies/enemy_bullet.tscn")
@onready var shoot_timer: Timer = %ShootTimer

var speed = 30.0
var facing_right = true
var max_health = 3
var health = 0
var face_direction = 1
var face_player = 1

@export var jump_power = 10.0
@export var jumpInterval = 5
var jump_multiplier = -30.0
var timeLeftToJump = jumpInterval

var Player : Player

func _ready():
	animation_player.play("move")
	Player = get_parent().get_node("Player")
	health = max_health
	jump_timer.timeout.connect(_on_jumpTimeout)
	jump_timer.start()
	shoot_timer.timeout.connect(_on_shootTimeout)

func _physics_process(delta: float) -> void:
	var player_position = Player.position
	var enemy_position = position
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Check if the player is to the right of the enemy
	if player_position.x > enemy_position.x:
		if face_direction == 1:
			face_player = -1
		else:
			face_player = 1
	else:
		if face_direction == 1:
			face_player = 1
		else:
			face_player = -1
	
	if face_player != -1:
		flip()
	
	velocity.x = speed
	
	move_and_slide()
	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		face_direction = 1
		speed = abs(speed)
	else:
		face_direction = -1
		speed = abs(speed) * -1
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_damage"):
		health -= 1
		if health == 0:
			Game_Manager.win()
			die()
			
func _on_jumpTimeout():
	if is_on_floor():
		velocity.y = jump_power * jump_multiplier
		
func _on_shootTimeout():
	var bullet_temp = bullet.instantiate()
	bullet_temp.dir=face_direction
	bullet_temp.pos=global_position+$EnemyBulletFiringPos.position
	bullet_temp.rota=face_direction
	animation_player.play("shoot")
	add_child(bullet_temp)
