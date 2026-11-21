extends CanvasLayer

const gameplay_scene:PackedScene = preload("res://scenes/areas/area_1.tscn")

@onready var start: Button = %StartButton
@onready var quit: Button = %QuitButton

func _on_start_button_pressed() -> void:
	Game_Manager.start_game()
	#get_tree().change_scene_to_packed(gameplay_scene)

func _on_quit_button_pressed() -> void:
	Game_Manager.quit_game()
	#get_tree().quit() # close the window
