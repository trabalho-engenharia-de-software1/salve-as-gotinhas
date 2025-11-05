# Anexado ao seu nó raiz "Control" da cena de menu
extends Control

# Pega a referência para o NÓ do botão de ajuda (o 'Button' com o script)
@onready var botao_de_ajuda = $HelpLayer/botaoAjuda # Verifique se o caminho está correto

# Pega a referência para o NÓ que você quer destacar
@onready var botao_jogar = $VBoxContainer/jogar

func _ready() -> void:
	# Espera 1 frame para garantir que 'botao_de_ajuda' e 'botao_jogar' carregaram
	await get_tree().process_frame

	# --- AQUI ESTÁ A MÁGICA ---
	# 1. O "diretor" (menu) acessa o script do "ator" (botao_de_ajuda)
	# 2. E define as "memórias" (as variáveis públicas) dele.
	botao_de_ajuda.no_alvo = botao_jogar
	botao_de_ajuda.texto_de_ajuda = "Clique em Jogar para começar a aventura!"
	
	# --- Suas conexões de botões ---
	# (Garanta que elas também estejam aqui)
	botao_jogar.pressed.connect(_on_jogar_pressed)
	$VBoxContainer/sair.pressed.connect(_on_sair_pressed)
	
func _on_jogar_pressed() -> void:
	print("botao jogar pressionado")
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-selecao-fase.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
