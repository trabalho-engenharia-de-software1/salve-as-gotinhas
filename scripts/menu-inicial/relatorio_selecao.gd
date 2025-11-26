extends Control

func _on_iniciarsomando_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/relatorio/relatorio_somando.tscn")
func _on_iniciarsubtraindo_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/relatorio/relatorio_subtraindo.tscn")
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")
