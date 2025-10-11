extends Node2D

# 1. Pré-carregue TODAS as texturas/imagens possíveis
const TEXTURA_1 = preload("res:///imagens/sprites-fase1/chuveiro.png")     # Se o valor for 1
const TEXTURA_2 = preload("res:///imagens/sprites-fase1/mangueira.png")     # Se o valor for 1 # Se o valor for 2
const TEXTURA_3 = preload("res:///imagens/sprites-fase1/regador.png")     # Se o valor for 1   # Se o valor for 3
const TEXTURA_4 = preload("res:///imagens/sprites-fase1/sanitario.png")     # Se o valor for 1
const TEXTURA_5 = preload("res:///imagens/sprites-fase1/torneira.png")     # Se o valor for 1
const TEXTURA_6 = preload("res:///imagens/sprites-fase1/bebedouro.png")     # Se o valor for 1
const TEXTURA_DEFAULT = preload("res:///imagens/sprites-fase1/vazamento.png") # Se o valor não existir
var erro = 0

func _ready():
	# 1. Recupera o array de acertos
	var acertos_fase_anterior = DadosDoJogo.botoes_corretos_fase1
	
	# Confia que o array tem pelo menos 2 itens (índices 0 e 1)
	
	# 2. Configura o PRIMEIRO Sprite (Posição de índice 0 do array)
	# Correção: Envie apenas o VALOR que está na posição 0 do array!
	_configurar_sprite($Sprite1, acertos_fase_anterior[0])
	
	# 3. Configura o SEGUNDO Sprite (Posição de índice 1 do array)
	# Correção: Envie apenas o VALOR que está na posição 1 do array!
	_configurar_sprite($Sprite2, acertos_fase_anterior[1])
	

func _configurar_sprite(sprite_alvo: Sprite2D, valor_do_botao: int):
	
	var nova_textura: Texture2D = TEXTURA_DEFAULT
	
	# Define qual textura deve ser carregada com base no valor.
	match valor_do_botao:
		1:
			nova_textura = TEXTURA_1
		2:
			nova_textura = TEXTURA_2
		3:
			nova_textura = TEXTURA_3
		4:
			nova_textura = TEXTURA_4
		5:
			nova_textura = TEXTURA_5
		6:
			nova_textura = TEXTURA_6
		_:
			# Se for um valor inesperado, usa a textura padrão
			push_error("Valor de botão inesperado no array: " + str(valor_do_botao))
			pass 
	
	# Aplica a textura ao nó Sprite2D
	if sprite_alvo:
		sprite_alvo.texture = nova_textura

func _on_resposta_4_button_down() -> void:
	erro += 1
	var texto_aviso = "essa resposta não é a correta"
	PopupManager.mostrar(texto_aviso)


func _on_resposta_3_button_down() -> void:
	erro += 1
	var texto_aviso = "essa resposta não é a correta"
	PopupManager.mostrar(texto_aviso)


func _on_resposta_2_button_down() -> void:
	DadosDoJogo.erro_etapa2 = erro
	var texto_aviso = "parabens, você acertou"
	PopupManager.mostrar(texto_aviso)
	ir_prox_etapa()


func _on_resposta_button_down() -> void:
	erro += 1
	var texto_aviso = "essa resposta não é a correta"
	PopupManager.mostrar(texto_aviso)

func ir_prox_etapa() -> void:
	
	# 1. SALVAR OS DADOS NO AUTOLOAD (DadosDoJogo)
	# Copia o array de acertos da Fase 1 para a variável global
	DadosDoJogo.erro_etapa2 = erro
	
	# 2. TROCA DE CENA
	var proxima_cena_path = "res://cenas/menu-inicial/menu-inicial.tscn" 
	
	if ResourceLoader.exists(proxima_cena_path):
		# Este comando troca a cena atual pela próxima
		get_tree().change_scene_to_file(proxima_cena_path) 
	else:
		# Exibe um erro se o arquivo não for encontrado no caminho especificado
		push_error("ERRO: O arquivo da próxima cena não foi encontrado: " + proxima_cena_path)
