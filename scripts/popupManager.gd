extends Node

var cena_popup = preload("res://cenas/popup.tscn")
var instancia_popup: Node = null

func _ready():
	print("3. PopupManager (Autoload) iniciado.")
	instancia_popup = cena_popup.instantiate()

	# 'await' para esperar o jogo carregar e evitar o crash inicial.
	await get_tree().process_frame
	
	get_tree().get_root().add_child(instancia_popup)
	
	print("4. Popup adicionado à árvore principal (root) com sucesso.")

func mostrar(texto: String):
	if instancia_popup:
		instancia_popup.mostrar_popup(texto)
	else:
		push_error("!!! ERRO: instancia_popup está nula!")
