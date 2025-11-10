extends Node2D

@onready var script_do_botao_ajuda = $HelpLayer/botaoAjuda
@onready var alvo_chuveiro = $botão1

var botoesPrecionados = []
var erro = 0
var qtd = 0
var valor = 0
var num = []
var inicio_fase: float
var fim_fase: float
var duracao: float

func _ready():
	# Espera 1 frame para garantir que todos os @onready carregaram
	await get_tree().process_frame
	inicio_fase = Time.get_unix_time_from_system()
	var pos_manual_reserv = Vector2(100, 100) # Use os valores que funcionam
	var raios_manual_reserv = Vector2(0, 0)
	var lista_de_passos = [
		{
			"tipo": "alvo_automatico",
			"alvo": alvo_chuveiro, # O alvo é o botão do chuveiro
			"texto": "Clique para escolher uma atividade que gasta agua."
		},
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": pos_manual_reserv,
			"raios_pixels": raios_manual_reserv,
			"texto": "Escolha 3 itens que gastam agua!"
		}
	]
	script_do_botao_ajuda.habilitar_ajuda_com_passos(lista_de_passos)

func _on_botão_1_button_down() -> void:
	botoesPrecionados.append(1)
	qtd = qtd +1
	colocar_valor()
	analizar_qtd()
	$botão1.disabled =true

func _on_botão_2_button_down() -> void:
	botoesPrecionados.append(2)
	qtd = qtd +1
	colocar_valor()
	analizar_qtd()
	$botão2.disabled =true

func _on_botão_3_button_down() -> void:
	erro = erro + 1
	var texto_aviso = "Esse item não gasta água!"
	var pos_centro_pc = Vector2(300, 75) # Posição (X, Y) do centro do computador
	var raios_pc = Vector2(55, 55)       # Tamanho do oval (Largura, Altura)
	PopupManager.mostrar_ajuda_manual(pos_centro_pc, raios_pc, texto_aviso)
	$botão3.disabled = true


func _on_botão_4_button_down() -> void:
	botoesPrecionados.append(3)
	qtd = qtd +1
	colocar_valor()
	analizar_qtd()
	$botão4.disabled =true


func _on_botão_5_button_down() -> void:
	botoesPrecionados.append(4)
	qtd = qtd +1
	colocar_valor()
	analizar_qtd()
	$botão5.disabled =true


func _on_botão_6_button_down() -> void:
	botoesPrecionados.append(5)
	qtd = qtd +1
	colocar_valor()
	analizar_qtd()
	$botão6.disabled =true


func _on_botão_7_button_down() -> void:
	erro = erro + 1
	var texto_aviso = "Esse item não gasta água!"
	var pos_centro_bola = Vector2(300, 185) # Posição (X, Y) do centro do computador
	var raios_bola = Vector2(38, 38)       # Tamanho do oval (Largura, Altura)
	PopupManager.mostrar_ajuda_manual(pos_centro_bola, raios_bola, texto_aviso)
	$botão7.disabled = true


func _on_botão_8_button_down() -> void:
	botoesPrecionados.append(6)
	qtd = qtd +1
	colocar_valor()
	analizar_qtd()
	$botão8.disabled = true

func colocar_valor() -> void:
	if qtd == 1:
		valor = randi()%2 + 3
		num.append(valor)
	if qtd == 2:
		valor = randi()%3 + 4
		num.append(valor)
	if qtd == 3:
		valor = randi()%4 + 7
		num.append(valor)
		
func analizar_qtd() -> void:
	if qtd == 3:
		ir_prox_etapa()
		
# No script da FASE 1

# ...

func ir_prox_etapa() -> void:
	
	# 1. SALVAR OS DADOS NO AUTOLOAD (DadosDoJogo)
	# Copia o array de acertos da Fase 1 para a variável global
	DadosDoJogo.botoes_corretos_fase1 = botoesPrecionados
	
	fim_fase = Time.get_unix_time_from_system()
	duracao = fim_fase - inicio_fase
	print("Duração total:", duracao, "s")
	DadosDoJogo.tempo1 =duracao
	DadosDoJogo.valores = num
	# Copia o contador de erros da Fase 1 para a variável global
	DadosDoJogo.erros_acumulados = erro
	
	# 2. TROCA DE CENA
	var proxima_cena_path = "res://cenas/fase1/etapa2_fase1.tscn" 
	
	if ResourceLoader.exists(proxima_cena_path):
		# Este comando troca a cena atual pela próxima
		get_tree().change_scene_to_file(proxima_cena_path) 
	else:
		# Exibe um erro se o arquivo não for encontrado no caminho especificado
		push_error("ERRO: O arquivo da próxima cena não foi encontrado: " + proxima_cena_path)
