class_name Moodeng extends Enemy

@export var animation_player : AnimationPlayer
@export var edge_dectection : RayCast2D
@export var wall_dectection : RayCast2D

var speed = 30.0
var facing_right = true

var Player : Player

func _ready():
	animation_player.play("move")
	Player = get_parent().get_node("Player")

func _physics_process(delta: float) -> void:
	
	#position += (Player.position - position)/50
	#look_at(Player.position)
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if !edge_dectection.is_colliding() && is_on_floor():
		flip()
	
	if wall_dectection.is_colliding():
		flip()
	
	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("hello")
	#if area.get_parent() is Player:
		#area.get_parent().take_damage(1)
	if area.is_in_group("player_damage"):
		die()

		
