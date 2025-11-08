extends Node2D

# 1. Pré-carregue TODAS as texturas/imagens possíveis
const TEXTURA_1 = preload("res:///imagens/sprites-fase1/chuveiro.png")
const TEXTURA_2 = preload("res:///imagens/sprites-fase1/mangueira.png")
const TEXTURA_3 = preload("res:///imagens/sprites-fase1/regador.png")
const TEXTURA_4 = preload("res:///imagens/sprites-fase1/sanitario.png")
const TEXTURA_5 = preload("res:///imagens/sprites-fase1/torneira.png")
const TEXTURA_6 = preload("res:///imagens/sprites-fase1/bebedouro.png")
const TEXTURA_DEFAULT = preload("res:///imagens/sprites-fase1/vazamento.png") 
var erro = 0
var qtd = 0 # (Seu código original, mantido)

# --- ADIÇÃO 1: Referência para o Botão de Ajuda ---
# (Assumindo que você arrastou o HelpLayer.tscn para esta cena)
@onready var script_do_botao_ajuda = $HelpLayer/botaoAjuda # Verifique o caminho!



func _ready():
	# --- SEU CÓDIGO ORIGINAL (Mantido) ---
	# 1. Recupera o array de acertos
	var acertos_fase_anterior = DadosDoJogo.botoes_corretos_fase1
	$Label.text = str(DadosDoJogo.valores[0])
	$Label2.text = str(DadosDoJogo.valores[1])
	$Label3.text = ' ' + str(DadosDoJogo.valores[0]+DadosDoJogo.valores[1]-1)
	$Label4.text = str(DadosDoJogo.valores[0]+DadosDoJogo.valores[1]-3)
	$Label6.text = str(DadosDoJogo.valores[0] + DadosDoJogo.valores[1])
	$Label7.text = str(DadosDoJogo.valores[0]+DadosDoJogo.valores[1]-2)
	# 2. Configura o PRIMEIRO Sprite (Posição de índice 0 do array)
	_configurar_sprite($Sprite1, acertos_fase_anterior[0])
	
	# 3. Configura o SEGUNDO Sprite (Posição de índice 1 do array)
	_configurar_sprite($Sprite2, acertos_fase_anterior[1])
	# --- FIM DO SEU CÓDIGO ORIGINAL ---
	
	
	# --- ADIÇÃO 2: Lógica do Tour de Ajuda ---
	
	# Espera 1 frame para garantir que tudo carregou
	await get_tree().process_frame
	
	# --- Crie a sua lista de 3 passos manuais aqui ---
	# (Você precisa ajustar os números de X, Y, Largura e Altura)
	var lista_de_passos = [
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(90, 80), 
			"raios_pixels": Vector2(50, 40),      
			"texto": "Este é o primeiro objeto que você escolheu."
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(200, 80),
			"raios_pixels": Vector2(50, 40),     
			"texto": "Este é o segundo objeto."
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(148, 133), 
			"raios_pixels": Vector2(140, 19),      
			"texto": "Some as gotas dos objetos."
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(404, 130), 
			"raios_pixels": Vector2(84, 130),      
			"texto": "Qual destas é a resposta correta para a soma?"
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(320, 140), 
			"raios_pixels": Vector2(15, 110),      
			"texto": "Escolha a resposta clicando no botao correto!"
		}
	]
	
	# Entrega a lista de passos para o script do botão de ajuda
	script_do_botao_ajuda.habilitar_ajuda_com_passos(lista_de_passos)
# --- FIM DA ADIÇÃO 2 ---
	
	
# ----- O RESTO DO SEU CÓDIGO CONTINUA 100% IGUAL -----

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
			push_error("Valor de botão inesperado no array: " + str(valor_do_botao))
			pass 
	
	if sprite_alvo:
		sprite_alvo.texture = nova_textura

func _on_resposta_4_button_down() -> void:
	erro += 1
	var texto_aviso = "essa resposta não é a correta"
	PopupManager.mostrar(texto_aviso) # <-- Isso usa o popup simples, está perfeito.


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
	var proxima_cena_path = "res://cenas/fase1/etapa3_fase1.tscn" 
	
	if ResourceLoader.exists(proxima_cena_path):
		# Este comando troca a cena atual pela próxima
		get_tree().change_scene_to_file(proxima_cena_path) 
	else:
		# Exibe um erro se o arquivo não for encontrado no caminho especificado
		push_error("ERRO: O arquivo da próxima cena não foi encontrado: " + proxima_cena_path)
