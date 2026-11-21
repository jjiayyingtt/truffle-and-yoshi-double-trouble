extends Node

@export var label_text = "0"
@onready var label: Label = %Label


func _ready() -> void:
	label.text = label_text
	label.visible = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		label.visible = true
