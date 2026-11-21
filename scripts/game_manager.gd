class_name GameManager extends Node

const game_over_scene = preload("res://scenes/menu/game_over_screen.tscn")
const pause_scene = preload("res://scenes/menu/pause_screen.tscn")
const area_1 = preload("res://scenes/areas/area_1.tscn")
const start_scene:PackedScene = preload("res://scenes/menu/start_screen.tscn")

var player : Player
var gameover_menu:GameOver
var pause_screen:PauseScreen

var gameover_label:String = "Game Over"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.play_music_level()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()

func respawn_player():
	#player.hearts = player.max_hearts
	player.position = Vector2(0,0)
	
	
func start_game():
	get_tree().change_scene_to_packed(area_1)
	
func pause_game():
	if not pause_screen:
		pause_screen = pause_scene.instantiate() as PauseScreen
		add_child(pause_screen)
		
func resume_game():
	if pause_screen:
		pause_screen.queue_free()
	if gameover_menu:
		gameover_menu.queue_free()

func restart_game():
	#get_tree().reload_current_scene()
	get_tree().change_scene_to_packed(area_1)
	resume_game()

func win():
	gameover_label = "You Win!"
	game_over()

func game_over():
	if not gameover_menu:
		gameover_menu = game_over_scene.instantiate() as GameOver
		print(gameover_label)
		add_child(gameover_menu)
		gameover_menu.set_label(gameover_label)
		
func quit_game():
	get_tree().quit()
	
