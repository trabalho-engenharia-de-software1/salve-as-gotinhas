# Anexado ao seu nó raiz "Control" da cena de menu
extends Control

# Pega a referência para o NÓ do botão de ajuda (o 'Button' com o script)
@onready var botao_ajuda = $HelpLayer/botaoAjuda # Verifique se o caminho está correto

# Pega a referência para o NÓ que você quer destacar
@onready var botao_jogar = $VBoxContainer/jogar
@onready var botao_creditos = $VBoxContainer/creditos
@onready var botao_sair = $VBoxContainer/sair

func _ready() -> void:
	# Espera 1 frame para garantir que todos os @onready carregaram
	await get_tree().process_frame

	# --- A Lista de Passos para o MENU ---
	var lista_de_passos = [
		{
			"tipo": "alvo_automatico",
			"alvo": botao_jogar, 
			"texto": "Clique em JOGAR para começar a aventura!"
		},
		{
			"tipo": "alvo_automatico",
			"alvo": botao_creditos,
			"texto": "Veja quem trabalhou neste jogo."
		},
		{
			"tipo": "alvo_automatico",
			"alvo": botao_sair,
			"texto": "clique em SAIR para fechar o jogo."
		}
	]
	# Entrega a lista de passos para o script do botão de ajuda
	botao_ajuda.habilitar_ajuda_com_passos(lista_de_passos)
	
	# --- Conecta os sinais dos botões ---
	botao_jogar.pressed.connect(_on_jogar_pressed)
	botao_sair.pressed.connect(_on_sair_pressed)
	# (Adicione conexões para 'configuracoes' e 'creditos' se eles tiverem funções)

func _on_jogar_pressed() -> void:
	print("botao jogar pressionado")
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-selecao-fase.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()


func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/creditos.tscn")


func _on_configuracoes_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/configuracoes.tscn")
