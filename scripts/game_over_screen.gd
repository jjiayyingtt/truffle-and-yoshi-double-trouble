class_name GameOver extends CanvasLayer

# remember to set them as unique name first!
@onready var restart: Button = %RestartButton
@onready var quit: Button = %QuitButton
@onready var win_label: Label = $Panel/HBoxContainer/VBoxContainer/WinLabel

func set_label(label_text):
	win_label.text = label_text

func _on_restart_button_pressed() -> void:
	Game_Manager.restart_game()
	#get_tree().reload_current_scene() # simple and easy for a single scene game like this

func _on_quit_button_pressed() -> void:
	Game_Manager.quit_game()
	#get_tree().quit() # close the window
	
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false
