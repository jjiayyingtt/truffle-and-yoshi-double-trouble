class_name Shooter extends Enemy

@onready var shoot_timer: Timer = $ShootTimer

@export var animation_player : AnimationPlayer
@export var edge_dectection : RayCast2D
@export var wall_dectection : RayCast2D

@export var speed = 10.0
@export var jump_power = 10.0
@export var jumpInterval = 5

var facing_right = true
var face_direction = 1

@onready var bullet = preload("res://scenes/enemies/enemy_bullet.tscn")

var Player : Player
var shoot_timer_started = false

func _ready() -> void:
	animation_player.play("idle")
	Player = get_parent().get_node("Player")
	shoot_timer.timeout.connect(_on_shootTimeout)
	#shoot_timer.start()

func _physics_process(delta: float) -> void:
	var player_position = Player.position
	var enemy_position = position # Or use $AnimatedSprite.position if you want to flip the sprite specifically
	#print(enemy_position.distance_to(player_position))
	
	animation_player.play("idle")
	if enemy_position.distance_to(player_position) < 100 && !shoot_timer_started:
		shoot_timer.start()
		shoot_timer_started = true
	
	# Check if the player is to the right of the enemy
	if player_position.x > enemy_position.x:
		scale.x = 1 # Face right
		$EnemyBulletFiringPos.position.x = 12
		face_direction = 1
	else:
		scale.x = -1 # Face left
		$EnemyBulletFiringPos.position.x = -12
		face_direction = -1
	
	
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	
func _on_shootTimeout():
	var bullet_temp = bullet.instantiate()
	bullet_temp.dir=face_direction
	bullet_temp.pos=global_position+$EnemyBulletFiringPos.position
	bullet_temp.rota=face_direction
	animation_player.play("shoot")
	add_child(bullet_temp)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_damage"):
		die()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		#player_left.emit()
		print("Player left enemy hitbox")
