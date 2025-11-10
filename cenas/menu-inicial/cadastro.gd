extends Node2D

@onready var entrada_nome: LineEdit = $LineEdit
@onready var botao: Button = $Button

func _ready():
	botao.pressed.connect(_on_botao_confirmar_pressed)

func _on_botao_confirmar_pressed() -> void:
	var nome = entrada_nome.text.strip_edges()
	if nome == "":
		print("⚠️ Nenhum nome digitado!")
		return
	
	print("✅ Nome inserido:", nome)
	
	# (opcional) salva o nome em um singleton global
	DadosDoJogo.nome_jogador = nome
	
	# muda de cena
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-selecao-fase.tscn")
