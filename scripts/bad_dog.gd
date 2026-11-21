class_name BadDog extends Enemy

@onready var jump_timer: Timer = $JumpTimer

@export var animation_player : AnimationPlayer
@export var edge_dectection : RayCast2D
@export var wall_dectection : RayCast2D

@export var speed = 10.0
@export var jump_power = 10.0
@export var jumpInterval = 5

var speed_multiplier = 5.0
var jump_multiplier = -30.0
var timeLeftToJump = jumpInterval
var facing_right = true

var Player : Player


func _ready() -> void:
	animation_player.play("move")
	Player = get_parent().get_node("Player")
	jump_timer.timeout.connect(_on_jumpTimeout)
	jump_timer.start()

func _process(delta: float) -> void:
	if velocity.y < 0.0:
		animation_player.play("jump")
	elif velocity.y > 0.0:
		animation_player.play("fall")
	else:
		animation_player.play("move")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if !edge_dectection.is_colliding() && is_on_floor():
		flip()
	
	if wall_dectection.is_colliding():
		flip()
	
	velocity.x = speed * speed_multiplier
	move_and_slide()
	
func _on_jumpTimeout():
	if is_on_floor():
		velocity.y = jump_power * jump_multiplier
	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_damage"):
		die()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		print("Player left enemy hitbox")
