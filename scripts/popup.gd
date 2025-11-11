# Anexado ao nó raiz "Popup" (CanvasLayer)
extends CanvasLayer

# --- Referências ---
@onready var overlay_escuro = $color
@onready var balao_texto = $color/caixaTexto
@onready var texto_ajuda = $color/caixaTexto/VBoxContainer/texto

# --- Timer ---
var timer_auto_fechar: Timer

func _ready():
	timer_auto_fechar = Timer.new()
	timer_auto_fechar.wait_time = 4.5
	timer_auto_fechar.one_shot = true
	add_child(timer_auto_fechar)
	timer_auto_fechar.timeout.connect(esconder_popup)
	hide()

# --- A NOVA FUNÇÃO "CÉREBRO" DE POSICIONAMENTO ---
func _posicionar_balao_inteligentemente(alvo_rect: Rect2):
	var balao_tamanho = balao_texto.size
	var tela_tamanho = get_viewport().get_visible_rect().size
	var folga = 30.0 # A folga que queremos da borda do alvo
	var pos_final = Vector2() # Onde o balão vai ficar

	# --- TENTATIVA 1: LADO DIREITO ---
	var pos_x_direita = alvo_rect.get_center().x + (alvo_rect.size.x / 2.0) + folga
	var pos_y_centro_vertical = alvo_rect.get_center().y - (balao_tamanho.y / 2.0)
	
	# Verifica se cabe no lado direito
	if pos_x_direita + balao_tamanho.x < tela_tamanho.x:
		pos_final = Vector2(pos_x_direita, pos_y_centro_vertical)
	
	# --- TENTATIVA 2: LADO ESQUERDO ---
	else:
		var pos_x_esquerda = alvo_rect.get_center().x - (alvo_rect.size.x / 2.0) - folga - balao_tamanho.x
		# Verifica se cabe no lado esquerdo
		if pos_x_esquerda > 0:
			pos_final = Vector2(pos_x_esquerda, pos_y_centro_vertical)
		
		# --- TENTATIVA 3: ABAIXO ---
		else:
			var pos_x_centro_horizontal = alvo_rect.get_center().x - (balao_tamanho.x / 2.0)
			var pos_y_abaixo = alvo_rect.get_center().y + (alvo_rect.size.y / 2.0) + folga
			
			# Verifica se cabe embaixo
			if pos_y_abaixo + balao_tamanho.y < tela_tamanho.y:
				pos_final = Vector2(pos_x_centro_horizontal, pos_y_abaixo)
			
			# --- TENTATIVA 4: ACIMA (Último recurso) ---
			else:
				var pos_y_acima = alvo_rect.get_center().y - (alvo_rect.size.y / 2.0) - folga - balao_tamanho.y
				pos_final = Vector2(pos_x_centro_horizontal, pos_y_acima)
	
	balao_texto.global_position = pos_final

# --- Função 1: Popup Simples (Game Over, etc.) ---
func mostrar_popup_simples(texto: String):
	# ... (código do overlay e do timer, como antes) ...
	overlay_escuro.material.set_shader_parameter("ellipse_radius_uv", Vector2(0, 0))
	overlay_escuro.show()
	
	# Centraliza o balão de texto (posição fixa)
	balao_texto.global_position = get_viewport().get_visible_rect().size / 2.0 - balao_texto.size / 2.0
	balao_texto.show()
	
	texto_ajuda.text = texto
	show()
	timer_auto_fechar.start()

# --- Função 2: Ajuda Contextual (Automática) ---
func mostrar_popup_de_ajuda(no_alvo: Node, mensagem: String):
	var alvo_rect: Rect2
	
	# ... (lógica para medir o 'alvo_rect', como antes) ...
	if no_alvo.has_method("get_global_rect"):
		alvo_rect = no_alvo.get_global_rect()
	elif no_alvo is Sprite2D and no_alvo.texture:
		alvo_rect = Rect2(no_alvo.global_position, no_alvo.texture.get_size() * no_alvo.scale)
	elif no_alvo is Node2D:
		alvo_rect = Rect2(no_alvo.global_position, Vector2(50, 50))
	else:
		hide()
		return
	
	# ... (código do shader oval, como antes) ...
	var tela_tamanho = get_viewport().get_visible_rect().size
	var centro_uv = alvo_rect.get_center() / tela_tamanho
	var padding_pixels = 10.0
	var raio_x_pixels = (alvo_rect.size.x / 2.0) + padding_pixels
	var raio_x_uv = raio_x_pixels / tela_tamanho.x
	var raio_y_pixels = (alvo_rect.size.y / 2.0) + padding_pixels
	var raio_y_uv = raio_y_pixels / tela_tamanho.y
	var raios_uv = Vector2(raio_x_uv, raio_y_uv)
	overlay_escuro.material.set_shader_parameter("ellipse_center_uv", centro_uv)
	overlay_escuro.material.set_shader_parameter("ellipse_radius_uv", raios_uv)
	overlay_escuro.show()

	# --- MUDANÇA: Chama a função inteligente de posicionamento ---
	_posicionar_balao_inteligentemente(alvo_rect)
	balao_texto.show()
	
	texto_ajuda.text = mensagem
	show()

# --- Função 3: Ajuda Manual (Para os popups de erro) ---
func mostrar_popup_de_ajuda_manual(pos_centro_pixels: Vector2, raios_pixels: Vector2, mensagem: String):
	var tela_tamanho = get_viewport().get_visible_rect().size
	
	# ... (código do shader oval, como antes) ...
	var centro_uv = pos_centro_pixels / tela_tamanho
	var raio_x_uv = raios_pixels.x / tela_tamanho.x
	var raio_y_uv = raios_pixels.y / tela_tamanho.y
	var raios_uv = Vector2(raio_x_uv, raio_y_uv)
	overlay_escuro.material.set_shader_parameter("ellipse_center_uv", centro_uv)
	overlay_escuro.material.set_shader_parameter("ellipse_radius_uv", raios_uv)
	overlay_escuro.show()
	
	# --- MUDANÇA: Constrói o 'alvo_rect' e chama a função inteligente ---
	var alvo_tamanho = raios_pixels * 2.0
	var pos_canto_superior_esquerdo = pos_centro_pixels - raios_pixels
	var alvo_rect_manual = Rect2(pos_canto_superior_esquerdo, alvo_tamanho)
	_posicionar_balao_inteligentemente(alvo_rect_manual)
	balao_texto.show()

	texto_ajuda.text = mensagem
	show()
	timer_auto_fechar.start()

func esconder_popup():
	hide()
