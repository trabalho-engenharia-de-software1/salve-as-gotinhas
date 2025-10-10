extends Node2D

# Quantidade de gotas que você quer mostrar
@export var quantidade: int = 5

func _ready():
	atualizar_gotinhas()

func atualizar_gotinhas():
	# Esconde todas as gotas primeiro
	for gota in get_children():
		gota.visible = false

	# Mostra apenas a quantidade desejada
	for i in range(min(quantidade, get_child_count())):
		get_child(i).visible = true
