extends Control

# O caminho DEVE ser este por causa da nossa hierarquia
@onready var agua_sprite: Sprite2D = $agua

var altura_total_agua: float
var largura_total_agua: float

func _ready():
	await get_tree().process_frame
	if agua_sprite.texture:
		altura_total_agua = agua_sprite.texture.get_height()
		largura_total_agua = agua_sprite.texture.get_width()
	
	atualizar_nivel(100.0, 100.0)

func atualizar_nivel(valor_atual: float, valor_maximo: float):
	if altura_total_agua == 0: return
	# O 'valor_atual' da lógica pode ser -1.0,
	# mas o 'valor_visual' que usamos para desenhar nunca pode ser menor que 0.
	var valor_visual = clamp(valor_atual, 0.0, valor_maximo)
	# --- FIM DA CORREÇÃO ---

	# Agora, todos os cálculos usam o 'valor_visual' (que nunca é negativo)
	var porcentagem = valor_visual / valor_maximo
	var nova_altura = altura_total_agua * porcentagem
	var nova_y = altura_total_agua - nova_altura 
	
	agua_sprite.region_rect = Rect2(0, nova_y, largura_total_agua, nova_altura)
