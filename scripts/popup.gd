# Anexado ao nó raiz "Popup" (CanvasLayer)
extends CanvasLayer

# --- Referências ---
# (Verifique se estes caminhos estão 100% corretos para sua cena 'Popup.tscn')
@onready var overlay_escuro = $color # O ColorRect com o SHADER
@onready var balao_texto = $color/caixaTexto # O Panel/Control
@onready var texto_ajuda = $color/caixaTexto/VBoxContainer/texto
@onready var botao_ok = $color/caixaTexto/botao

func _ready():
	botao_ok.pressed.connect(esconder_popup)
	hide()

# --- Função 1: Chamada pelo PopupManager.mostrar() ---
func mostrar_popup_simples(texto: String):
	# Esconde o círculo (raio = 0)
	overlay_escuro.material.set_shader_parameter("circle_radius", 0.0)
	
	# Mostra o texto e o popup
	texto_ajuda.text = texto
	show()

# --- Função 2: Chamada pelo PopupManager.mostrar_ajuda_contextual() ---
func mostrar_popup_de_ajuda(no_alvo: Node, mensagem: String):
	# Pega o retângulo do "alvo" que o botão de ajuda nos enviou
	var alvo_rect = no_alvo.get_global_rect()
	
	# --- POSICIONA O OVAL DO SHADER ---
	
	# Pega o tamanho (largura e altura) da tela
	var tela_tamanho = get_viewport().get_visible_rect().size
	
	# Pega o centro do alvo (isso não muda)
	var centro_uv = alvo_rect.get_center() / tela_tamanho
	
	# --- AQUI ESTÁ A MUDANÇA ---
	# Define uma "folga" em pixels para o oval
	var padding_pixels = 10.0
	
	# Calcula o RAIO X (horizontal) baseado na LARGURA do alvo
	var raio_x_pixels = (alvo_rect.size.x / 2.0) + padding_pixels
	var raio_x_uv = raio_x_pixels / tela_tamanho.x
	
	# Calcula o RAIO Y (vertical) baseado na ALTURA do alvo
	var raio_y_pixels = (alvo_rect.size.y / 2.0) + padding_pixels
	var raio_y_uv = raio_y_pixels / tela_tamanho.y
	
	# Cria um Vetor2 com os dois raios UV
	var raios_uv = Vector2(raio_x_uv, raio_y_uv)
	
	# Envia as novas coordenadas para o shader
	overlay_escuro.material.set_shader_parameter("ellipse_center_uv", centro_uv)
	overlay_escuro.material.set_shader_parameter("ellipse_radius_uv", raios_uv)
	
	# --- POSICIONA O BALÃO E A SETA (Ajuste os números) ---
	# CORREÇÃO DA POSIÇÃO: Coloca o balão ABAIXO do centro do alvo
	var offset_y = alvo_rect.size.y / 2.0 + 30.0 # 30 pixels abaixo da borda inferior do alvo
	
	# Define o texto e mostra o popup
	texto_ajuda.text = mensagem
	show()

func esconder_popup():
	hide()
