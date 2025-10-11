extends Control

@onready var botao_de_ajuda = $HelpLayer/botaoAjuda

func _ready() -> void:
	botao_de_ajuda.texto_de_ajuda = "Clique em uma das opcoes!"
	
func _on_jogar_pressed() -> void:
	print("botao jogar pressionado")
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-selecao-fase.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
