extends Control

@onready var botao_de_ajuda = $HelpLayer/botaoAjuda

func _ready() -> void:
	botao_de_ajuda.texto_de_ajuda = "Escolha uma das fases para jogar!"

func _on_iniciarfase_1_pressed() -> void:
	print("botao iniciar fase 1 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase1/fase1_cena.tscn")


func _on_iniciarfase_2_pressed() -> void:
	print("botao iniciar fase 2 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase2/fase2_cena.tscn")
