class_name PauseScreen extends CanvasLayer

@onready var resume: Button = %ResumeButton
@onready var restart: Button = %RestartButton

func _on_resume_button_pressed() -> void:
	Game_Manager.resume_game()
	#queue_free()
	
func _process(delta:float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Game_Manager.resume_game()
		#queue_free()

func _on_restart_button_pressed() -> void:
	Game_Manager.restart_game()
	#get_tree().reload_current_scene()
	
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false
