class_name Bullet extends CharacterBody2D

var pos:Vector2
var rota:float
var dir:float
var speed = 200

func _ready() -> void:
	global_position = pos
	global_rotation = rota
	
func set_pos(pos_global):
	global_position = pos_global
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(dir*speed,0)
	move_and_slide()
	if velocity == Vector2(0,0):
		call_deferred("queue_free")
