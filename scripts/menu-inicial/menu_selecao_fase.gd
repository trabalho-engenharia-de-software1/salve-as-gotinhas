extends Control

@onready var botao_de_ajuda = $HelpLayer/botaoAjuda # Verifique se o caminho está correto

# Pega a referência para o NÓ que você quer destacar
@onready var botao_jogar = $iniciarfase1

func _ready() -> void:
	# Espera 1 frame para garantir que 'botao_de_ajuda' e 'botao_jogar' carregaram
	await get_tree().process_frame

	# --- AQUI ESTÁ A MÁGICA ---
	# 1. O "diretor" (menu) acessa o script do "ator" (botao_de_ajuda)
	# 2. E define as "memórias" (as variáveis públicas) dele.
	botao_de_ajuda.no_alvo = botao_jogar
	botao_de_ajuda.texto_de_ajuda = "Clique em Jogar para começar a aventura!"
	
	# --- Suas conexões de botões ---
	# (Garanta que elas também estejam aqui

func _on_iniciarfase_1_pressed() -> void:
	print("botao iniciar fase 1 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase1/fase1_cena.tscn")


func _on_iniciarfase_2_pressed() -> void:
	print("botao iniciar fase 2 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase2/fase2_cena.tscn")
