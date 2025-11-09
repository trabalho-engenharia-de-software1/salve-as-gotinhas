extends Node2D

@onready var som_hover: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var area: Area2D = $Area2D

func _ready():
	if area:
		area.input_pickable = true
		area.mouse_entered.connect(_on_area_2d_mouse_entered)
	else:
		push_error("⚠️ Area2D não encontrada! Verifique a hierarquia.")

func _on_area_2d_mouse_entered() -> void:
	print("Mouse entrou em:", name)
	if som_hover and not som_hover.playing:
		som_hover.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")
