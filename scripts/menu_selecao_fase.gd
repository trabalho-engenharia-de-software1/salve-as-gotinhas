extends Control


func _on_iniciarfase_1_pressed() -> void:
	print("botao iniciar fase 1 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase1/fase1_cena.tscn")


func _on_iniciarfase_2_pressed() -> void:
	print("botao iniciar fase 2 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase2/fase2_cena.tscn")
