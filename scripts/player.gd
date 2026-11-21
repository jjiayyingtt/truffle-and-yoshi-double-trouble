class_name Player extends CharacterBody2D

@export var speed = 8.0
@export var jump_power = 10.0


var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var face_direction = 1

#var max_hearts = 3
#var hearts = 0
#var can_take_damage = true

var can_double_jump = true

@onready var bullet = preload("res://scenes/player_bullet.tscn")
@onready var jump_sfx: AudioStreamPlayer = $jump_sfx
@onready var shoot_sfx: AudioStreamPlayer = $shoot_sfx


func _ready():
	Game_Manager.player = self

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		jump_sfx.play()
		
	if Input.is_action_just_pressed("jump") and not is_on_floor() and can_double_jump:
		velocity.y = jump_power * jump_multiplier
		jump_sfx.play()
		can_double_jump = false
		
	if is_on_floor():
		can_double_jump = true

	# Handle shooting
	if Input.is_action_just_pressed("shoot"):
		shoot()

	# Skip movement if holding shoot
	if Input.is_action_pressed("shoot"):
		velocity.x = 0
		move_and_slide()
		return

	# Handle movement normally
	direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		face_direction = direction
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
		
	$BulletFiringPos.position.x = face_direction*9

	move_and_slide()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_damage"):
		take_damage(1)
		area.call_deferred("queue_free")
	elif area.is_in_group("enemy") or area.get_parent() is Enemy:
		take_damage(1)
		
#func _on_damage_timer_timeout() -> void:
	#if in_enemy_hitbox:
		#take_damage(1)

func shoot():
	var bullet_temp = bullet.instantiate()
	bullet_temp.dir=face_direction
	bullet_temp.rota=global_rotation
	bullet_temp.set_pos($BulletFiringPos.global_position)
	shoot_sfx.play()
	get_parent().add_child(bullet_temp)
	
func take_damage(damage_amount:int):
	die()
	
func die():
	Game_Manager.game_over()
