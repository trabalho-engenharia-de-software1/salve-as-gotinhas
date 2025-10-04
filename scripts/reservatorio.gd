# Script: reservatorio.gd
# Anexado ao nó raiz da cena Reservatorio.tscn

extends Node2D

@onready var agua_sprite: Sprite2D = $agua
var altura_total_agua: float
var largura_total_agua: float

func _ready():
	# Espera um frame para garantir que a textura foi carregada
	await get_tree().process_frame
	altura_total_agua = agua_sprite.texture.get_height()
	largura_total_agua = agua_sprite.texture.get_width()
	
	# Garante que o reservatório comece cheio
	atualizar_nivel(100.0, 100.0)

# Função pública que o "chefe" vai chamar para atualizar o nível
func atualizar_nivel(valor_atual: float, valor_maximo: float):
	if altura_total_agua == 0: return # Proteção contra erro na inicialização

	# Calcula a porcentagem de água que ainda temos (um número de 0.0 a 1.0)
	var porcentagem = valor_atual / valor_maximo
	
	# Calcula a nova ALTURA do nosso "corte" na imagem
	var nova_altura_do_corte = altura_total_agua * porcentagem
	
	# Calcula a posição Y do TOPO do nosso "corte"
	var nova_pos_y_do_corte = 0
	
	# Aplica o novo "corte" retangular na sprite da água
	agua_sprite.region_rect = Rect2(0, nova_pos_y_do_corte, largura_total_agua, nova_altura_do_corte)
