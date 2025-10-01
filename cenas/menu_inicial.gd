extends Control


func _on_jogar_pressed() -> void:
	print("botao jogar pressionado")
	get_tree().change_scene_to_file("res://cenas/menu-selecao-fase.tscn")
	


func _on_sair_pressed() -> void:
	get_tree().quit()
