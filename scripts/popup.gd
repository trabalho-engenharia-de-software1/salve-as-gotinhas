# Anexado ao nó raiz "Popup" (CanvasLayer)
extends CanvasLayer

# --- Referências (Corrigidas, sem o 'botao_ok') ---
@onready var overlay_escuro = $color # O ColorRect com o SHADER
@onready var balao_texto = $color/caixaTexto # O Panel/Control
@onready var texto_ajuda = $color/caixaTexto/VBoxContainer/texto
# A linha do '@onready var botao_ok' foi REMOVIDA.

func _ready():
	# A linha 'botao_ok.pressed.connect(esconder_popup)' foi REMOVIDA.
	hide()

# --- Função 1: Popup Simples (Game Over, etc.) ---
func mostrar_popup_simples(texto: String):
	# Esconde o "buraco" do shader (define raios como 0)
	overlay_escuro.material.set_shader_parameter("ellipse_radius_uv", Vector2(0, 0))
	overlay_escuro.show()
	
	# O balão fica onde está (posição fixa do editor)
	balao_texto.show()
	
	texto_ajuda.text = texto
	show() # Mostra o CanvasLayer (o popup inteiro)

# --- Função 2: Ajuda Contextual (com Oval) ---
# --- Função 2: Ajuda Contextual (Agora mais inteligente) ---
func mostrar_popup_de_ajuda(no_alvo: Node, mensagem: String):
	
	var alvo_rect: Rect2 # Cria uma variável para guardar o retângulo
	
	# --- AQUI ESTÁ A LÓGICA CORRIGIDA ---
	
	# 1. Ele tenta o método fácil (para nós de UI como 'Button' ou 'TextureRect')
	if no_alvo.has_method("get_global_rect"):
		alvo_rect = no_alvo.get_global_rect()
	
	# 2. Se falhar, ele checa se é um 'Sprite2D' (que tem textura)
	elif no_alvo is Sprite2D:
		if no_alvo.texture:
			# Calcula o retângulo manualmente (funciona com Centered=desligado)
			alvo_rect = Rect2(no_alvo.global_position, no_alvo.texture.get_size() * no_alvo.scale)
		else:
			# Se for uma Sprite2D sem textura, só faz um círculo na posição
			alvo_rect = Rect2(no_alvo.global_position, Vector2(20, 20))
	
	# 3. Se falhar, ele checa se é um 'Node2D' genérico (como o seu 'Gotas')
	elif no_alvo is Node2D:
		# Ele não tem tamanho! Então só podemos destacar sua posição.
		print("Aviso de Ajuda: O alvo é um Node2D (container). Usando um círculo de tamanho fixo.")
		# Vamos criar um retângulo "padrão" na posição do nó
		alvo_rect = Rect2(no_alvo.global_position, Vector2(50, 50)) # 50x50 pixels
	
	else:
		print("ERRO DE AJUDA: O nó alvo não é nem Control nem Node2D.")
		hide() # Se esconde para não quebrar
		return
	# --- FIM DA LÓGICA CORRIGIDA ---
	
	
	# --- POSICIONA O OVAL DO SHADER (Este código continua igual) ---
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
	
	# O balão fica onde está (posição fixa do editor)
	balao_texto.show()
	
	texto_ajuda.text = mensagem
	show() # Mostra o CanvasLayer (o popup inteiro)

func mostrar_popup_de_ajuda_manual(pos_centro_pixels: Vector2, raios_pixels: Vector2, mensagem: String):
	var tela_tamanho = get_viewport().get_visible_rect().size
	
	# --- POSICIONA O OVAL (com valores manuais) ---
	var centro_uv = pos_centro_pixels / tela_tamanho
	var raio_x_uv = raios_pixels.x / tela_tamanho.x
	var raio_y_uv = raios_pixels.y / tela_tamanho.y
	var raios_uv = Vector2(raio_x_uv, raio_y_uv)
	
	overlay_escuro.material.set_shader_parameter("ellipse_center_uv", centro_uv)
	overlay_escuro.material.set_shader_parameter("ellipse_radius_uv", raios_uv)
	
	# --- MOSTRA O RESTO ---
	overlay_escuro.show()
	balao_texto.show()
	texto_ajuda.text = mensagem
	show()

# Função para o PopupManager ou o '?' chamar
func esconder_popup():
	hide()
