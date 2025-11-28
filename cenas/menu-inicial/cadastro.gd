extends Control

@onready var line_edit_nome: LineEdit = $LineEdit
@onready var botao_confirmar: Button = $Button

func _ready():
	# Conecta o sinal 'pressed' (clique) do botão à nossa função
	botao_confirmar.pressed.connect(_on_confirmar_pressed)
	# Conecta o "Enter" do teclado (text_submitted)
	line_edit_nome.text_submitted.connect(_on_confirmar_pressed)
	# Foca o cursor no LineEdit quando a cena começa
	line_edit_nome.grab_focus()

# Esta função é chamada quando o botão "Confirmar" é pressionado ou quando o "Enter" é apertado
func _on_confirmar_pressed():
	# Pega o texto que o usuário digitou
	var nome_jogador = line_edit_nome.text
	
	# Verifica se o nome não está vazio
	if nome_jogador.is_empty():
		PopupManager.mostrar("Por favor, insira um nome!") # Se estiver vazio, mostra um popup de erro
		return # Para a função aqui
		
	# Senao, Salva o nome na variavel global
	if DadosDoJogo:
		DadosDoJogo.nome_jogador = nome_jogador
	
	# E muda para a cena de selecao de fase
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-selecao-fase.tscn")


func _on_area_mouse_entered() -> void:
	pass # Replace with function body.


func _on_area_mouse_exited() -> void:
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	pass # Replace with function body.


func _on_area_2d_mouse_entered() -> void:
	pass # Replace with function body.
