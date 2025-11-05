# Anexado ao seu Autoload: PopupManager.gd
extends Node

var cena_popup = preload("res://cenas/popup.tscn") # VERIFIQUE O CAMINHO
var instancia_popup: Node = null

func _ready():
	print("3. PopupManager (Autoload) iniciado.")
	instancia_popup = cena_popup.instantiate()
	await get_tree().process_frame
	get_tree().get_root().add_child(instancia_popup)
	print("4. Popup adicionado à árvore principal (root) com sucesso.")

# --- FUNÇÃO 1: A SUA FUNÇÃO ORIGINAL (Para Popups Simples) ---
func mostrar(texto: String):
	if instancia_popup:
		# Pede ao popup para mostrar SÓ a caixa de texto
		instancia_popup.mostrar_popup_simples(texto)
	else:
		push_error("!!! ERRO: instancia_popup está nula!")

# --- FUNÇÃO 2: A NOVA FUNÇÃO (Para o Círculo de Ajuda) ---
func mostrar_ajuda_contextual(no_para_realcar: Node, mensagem: String):
	if instancia_popup:
		# Pede ao popup para mostrar o CÍRCULO e o BALÃO
		instancia_popup.mostrar_popup_de_ajuda(no_para_realcar, mensagem)
	else:
		push_error("!!! ERRO: instancia_popup está nula!")
