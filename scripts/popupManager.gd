extends Node

# O SINAL 'tour_cancelado_pelo_popup' FOI REMOVIDO

var cena_popup = preload("res://cenas/popup.tscn")
var instancia_popup: Node = null

func _ready():
	instancia_popup = cena_popup.instantiate()
	await get_tree().process_frame
	get_tree().get_root().add_child(instancia_popup)
	
	# A CONEXÃO 'instancia_popup.popup_fechado_manualmente.connect' FOI REMOVIDA
	
# A FUNÇÃO '_on_popup_fechado' FOI REMOVIDA

# --- As funções de "mostrar" e "esconder" continuam IGUAIS ---
func mostrar(texto: String):
	if instancia_popup:
		instancia_popup.mostrar_popup_simples(texto)

func mostrar_ajuda_manual(pos_centro_pixels: Vector2, raios_pixels: Vector2, mensagem: String):
	if instancia_popup:
		instancia_popup.mostrar_popup_de_ajuda_manual(pos_centro_pixels, raios_pixels, mensagem)

func mostrar_ajuda_contextual(no_para_realcar: Node, mensagem: String):
	if instancia_popup:
		instancia_popup.mostrar_popup_de_ajuda(no_para_realcar, mensagem)

func esconder_ajuda():
	if instancia_popup:
		instancia_popup.esconder_popup()
