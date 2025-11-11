# Anexado ao nó raiz "Cadastro" (do tipo Control)
extends Control

# --- Referências para os seus nós ---
# (Verifique se os nomes batem com a sua árvore de cena!)
@onready var line_edit_nome: LineEdit = $LineEdit
@onready var botao_confirmar: Button = $Button

func _ready():
	# 1. Conecta o sinal 'pressed' (clique) do botão à nossa função
	botao_confirmar.pressed.connect(_on_confirmar_pressed)
	
	# 2. BÔNUS: Conecta o "Enter" do teclado (text_submitted)
	# para também chamar a mesma função
	line_edit_nome.text_submitted.connect(_on_confirmar_pressed)
	
	# Foca o cursor no LineEdit quando a cena começa
	line_edit_nome.grab_focus()

# Esta função é chamada quando o botão "Confirmar" é pressionado
# OU quando o "Enter" é apertado no LineEdit
func _on_confirmar_pressed():
	# Pega o texto que o usuário digitou
	var nome_jogador = line_edit_nome.text
	
	# 1. Verifica se o nome não está vazio
	if nome_jogador.is_empty():
		# Se estiver vazio, mostra um popup de erro
		# (Isso usa o seu PopupManager que já está funcionando)
		PopupManager.mostrar("Por favor, insira um nome!")
		return # Para a função aqui e não continua
		
	# 2. Salva o nome no seu Autoload
	# (Assumindo que seu Autoload se chama 'DadosDoJogo')
	if DadosDoJogo:
		DadosDoJogo.nome_jogador = nome_jogador
		print("Nome salvo globalmente: ", DadosDoJogo.nome_jogador)
	else:
		push_error("ERRO: Autoload 'DadosDoJogo' não foi encontrado!")
	
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-selecao-fase.tscn")
