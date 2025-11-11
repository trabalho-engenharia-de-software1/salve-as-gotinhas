extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")


func _on_area_mouse_entered() -> void:
	pass # Replace with function body.
