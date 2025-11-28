extends Node2D

# 1. Pré-carregue TODAS as texturas/imagens possíveis
const TEXTURA_1 = preload("res:///imagens/sprites-fase1/chuveiro.png")
const TEXTURA_2 = preload("res:///imagens/sprites-fase1/mangueira.png")
const TEXTURA_3 = preload("res:///imagens/sprites-fase1/regador.png")
const TEXTURA_4 = preload("res:///imagens/sprites-fase1/sanitario.png")
const TEXTURA_5 = preload("res:///imagens/sprites-fase1/torneira.png")
const TEXTURA_6 = preload("res:///imagens/sprites-fase1/bebedouro.png")
const TEXTURA_DEFAULT = preload("res:///imagens/sprites-fase1/vazamento.png") 

const AUDIO_1 = preload("res://narracao/objetos/chuveiro.wav")
const AUDIO_2 = preload("res://narracao/objetos/mangueira .wav")
const AUDIO_3 = preload("res://narracao/objetos/regador.wav")
const AUDIO_4 =preload("res://narracao/objetos/descarga.wav")
const AUDIO_5 = preload("res://narracao/objetos/torneira.wav")
const AUDIO_6 = preload("res://narracao/objetos/bebedouro.wav")
const AUDIO_DEFAULT =preload("res://narracao/objetos/vazamento .wav")
const AUDIO3 = preload("res://narracao/gotinhas/positivo/3.wav")
const AUDIO4 = preload("res://narracao/gotinhas/positivo/4.wav")
const AUDIO5 = preload("res://narracao/gotinhas/positivo/5.wav")
const AUDIO6 = preload("res://narracao/gotinhas/positivo/6.wav")
const AUDIO7 = preload("res://narracao/gotinhas/positivo/7.wav")
const AUDIO8 = preload("res://narracao/gotinhas/positivo/8.wav")
const AUDIO9 = preload("res://narracao/gotinhas/positivo/9.wav")
const AUDIO10 = preload("res://narracao/gotinhas/positivo/10.wav")
const AUDIO11 = preload("res://narracao/gotinhas/positivo/2.wav")
const AUDIO12 = preload("res://narracao/gotinhas/positivo/1.wav")

var erro = 0
var qtd = 0 # (Seu código original, mantido)

var inicio_fase: float
var fim_fase: float
var duracao: float
# --- ADIÇÃO 1: Referência para o Botão de Ajuda ---
# (Assumindo que você arrastou o HelpLayer.tscn para esta cena)
@onready var script_do_botao_ajuda = $HelpLayer/botaoAjuda # Verifique o caminho!



func _ready():
	# --- SEU CÓDIGO ORIGINAL (Mantido) ---
	# 1. Recupera o array de acertos
	await get_tree().process_frame
	inicio_fase = Time.get_unix_time_from_system()
	var acertos_fase_anterior = DadosDoJogo.botoes_corretos_fase1
	_configurar_label($Label, DadosDoJogo.valores[0], $Label/AudioStreamPlayer2D)
	_configurar_label($Label2, DadosDoJogo.valores[1], $Label2/AudioStreamPlayer2D)
	_configurar_label($Label3, DadosDoJogo.valores[0]+DadosDoJogo.valores[1]-1, $Label3/AudioStreamPlayer2D)
	_configurar_label($Label4, DadosDoJogo.valores[0]+DadosDoJogo.valores[1]-3, $Label4/AudioStreamPlayer2D)
	_configurar_label($Label6, DadosDoJogo.valores[0] + DadosDoJogo.valores[1], $Label6/AudioStreamPlayer2D)
	_configurar_label($Label7, DadosDoJogo.valores[0]+DadosDoJogo.valores[1]-2, $Label7/AudioStreamPlayer2D)
	# 2. Configura o PRIMEIRO Sprite (Posição de índice 0 do array)
	_configurar_sprite($Sprite1, acertos_fase_anterior[0],$Sprite1/AudioStreamPlayer2D)
	
	# 3. Configura o SEGUNDO Sprite (Posição de índice 1 do array)
	_configurar_sprite($Sprite2, acertos_fase_anterior[1],$Sprite2/AudioStreamPlayer2D)
	# --- FIM DO SEU CÓDIGO ORIGINAL ---
	
	
	# --- ADIÇÃO 2: Lógica do Tour de Ajuda ---
	
	# Espera 1 frame para garantir que tudo carregou
	await get_tree().process_frame
	
	# --- Crie a sua lista de 3 passos manuais aqui ---
	# (Você precisa ajustar os números de X, Y, Largura e Altura)
	var lista_de_passos = [
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(72, 95), 
			"raios_pixels": Vector2(50, 40),      
			"texto": "Este é o primeiro objeto que você escolheu.",
			"audio": preload("res://narracao/fase 1/este e o primeiro objeto que vc escolheu.wav")
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(215, 95),
			"raios_pixels": Vector2(50, 40),     
			"texto": "Este é o segundo objeto.",
			"audio": preload("res://narracao/fase 1/e este e o segundo.wav")
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(148, 155), 
			"raios_pixels": Vector2(140, 37),      
			"texto": "Some as gotas dos objetos.",
			"audio": preload("res://narracao/fase 1/some as gotas dos objetos.wav")
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(348, 130), 
			"raios_pixels": Vector2(67, 140),      
			"texto": "Qual destas é a resposta correta para a soma?",
			"audio": preload("res://narracao/fase 1/qual destas e a resposta correta para a soma .wav")
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": Vector2(450, 140), 
			"raios_pixels": Vector2(20, 110),      
			"texto": "Escolha a resposta clicando no botão correto!"
		}
	]
	
	# Entrega a lista de passos para o script do botão de ajuda
	script_do_botao_ajuda.habilitar_ajuda_com_passos(lista_de_passos)
	script_do_botao_ajuda.iniciar_tour_automatico()
# --- FIM DA ADIÇÃO 2 ---
func _configurar_label(label_alvo: Label, valor_do_botao: int, audio_alvo: AudioStreamPlayer2D):
	
	var novo_texto: String = "nada"
	var novo_audio: AudioStream = AUDIO_DEFAULT
	# Define qual textura deve ser carregada com base no valor.
	match valor_do_botao:
		1:
			novo_texto = " 1"
			novo_audio = AUDIO12
		2:
			novo_texto = " 2"
			novo_audio = AUDIO11
		3:
			novo_texto = " 3"
			novo_audio = AUDIO3
		4:
			novo_texto = " 4"
			novo_audio = AUDIO4
		5:
			novo_texto = " 5"
			novo_audio = AUDIO5
		6:
			novo_texto = " 6"
			novo_audio = AUDIO6
		7:
			novo_texto = " 7"
			novo_audio = AUDIO7
		8:
			novo_texto = " 8"
			novo_audio = AUDIO8
		9:
			novo_texto = " 9"
			novo_audio = AUDIO9
		10:
			novo_texto = "10"
			novo_audio = AUDIO10
		_:
			push_error("Valor de botão inesperado no array: " + str(valor_do_botao))
			pass 
	
	if label_alvo:
		label_alvo.text = novo_texto
		audio_alvo.stream = novo_audio
		print("🔊 Áudio atribuído a", label_alvo.name, "→", novo_audio.resource_path)
	
# ----- O RESTO DO SEU CÓDIGO CONTINUA 100% IGUAL -----

func _configurar_sprite(sprite_alvo: Sprite2D, valor_do_botao: int, audio_alvo: AudioStreamPlayer2D):
	
	var nova_textura: Texture2D = TEXTURA_DEFAULT
	var novo_audio: AudioStream = AUDIO_DEFAULT
	# Define qual textura deve ser carregada com base no valor.
	match valor_do_botao:
		1:
			nova_textura = TEXTURA_1
			novo_audio = AUDIO_1
		2:
			nova_textura = TEXTURA_2
			novo_audio = AUDIO_2
		3:
			nova_textura = TEXTURA_3
			novo_audio = AUDIO_3
		4:
			nova_textura = TEXTURA_4
			novo_audio = AUDIO_4
		5:
			nova_textura = TEXTURA_5
			novo_audio = AUDIO_5
		6:
			nova_textura = TEXTURA_6
			novo_audio = AUDIO_6
		_:
			push_error("Valor de botão inesperado no array: " + str(valor_do_botao))
			pass 
	
	if sprite_alvo:
		sprite_alvo.texture = nova_textura
		audio_alvo.stream = novo_audio
		print("🔊 Áudio atribuído a", sprite_alvo.name, "→", novo_audio.resource_path)

func _on_resposta_4_button_down() -> void:
	erro += 1
	var audio = preload("res://narracao/fase 1/esta nao e a resposta correta.wav")
	var texto_aviso = "essa não e a resposta correta"
	PopupManager.mostrar(texto_aviso) 
	NarradorGlobal.tocar_narracao(audio, true)


func _on_resposta_3_button_down() -> void:
	erro += 1
	var audio = preload("res://narracao/fase 1/esta nao e a resposta correta.wav")
	var texto_aviso = "essa não e a resposta correta"
	PopupManager.mostrar(texto_aviso)
	NarradorGlobal.tocar_narracao(audio, true)


func _on_resposta_2_button_down() -> void:
	DadosDoJogo.erro_etapa2 = erro
	var audio = preload("res://narracao/fase 1/parabens vamos complicar agora.wav")
	var texto_aviso = "parabéns, vamos complicar agora"
	PopupManager.mostrar(texto_aviso)
	NarradorGlobal.tocar_narracao(audio, true)
	ir_prox_etapa()


func _on_resposta_button_down() -> void:
	erro += 1
	var audio = preload("res://narracao/fase 1/esta nao e a resposta correta.wav")
	var texto_aviso = "essa não e a resposta correta"
	PopupManager.mostrar(texto_aviso)
	NarradorGlobal.tocar_narracao(audio, true)

func ir_prox_etapa() -> void:
	
	# 1. SALVAR OS DADOS NO AUTOLOAD (DadosDoJogo)
	# Copia o array de acertos da Fase 1 para a variável global
	fim_fase = Time.get_unix_time_from_system()
	duracao = fim_fase - inicio_fase
	print("Duração total:", duracao, "s")
	DadosDoJogo.erro_etapa2 = erro
	DadosDoJogo.tempo2 = duracao
	# 2. TROCA DE CENA
	var proxima_cena_path = "res://cenas/fase1/etapa3_fase1.tscn" 
	
	if ResourceLoader.exists(proxima_cena_path):
		# Este comando troca a cena atual pela próxima
		get_tree().change_scene_to_file(proxima_cena_path) 
	else:
		# Exibe um erro se o arquivo não for encontrado no caminho especificado
		push_error("ERRO: O arquivo da próxima cena não foi encontrado: " + proxima_cena_path)


func _on_area_mouse_exited() -> void:
	pass # Replace with function body.


func _on_area_mouse_entered() -> void:
	pass # Replace with function body.
