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

	var porcentagem = valor_atual / valor_maximo
	var nova_altura = altura_total_agua * porcentagem
	# Esta é a lógica para esvaziar por cima
	var nova_y = altura_total_agua
	
	agua_sprite.region_rect = Rect2(0, nova_y, largura_total_agua, nova_altura)
