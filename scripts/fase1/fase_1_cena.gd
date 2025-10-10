extends Node2D

var botoesPrecionados = []
var erro = 0
var qtd = 0


func _on_botão_1_button_down() -> void:
	botoesPrecionados.append(1)
	qtd = qtd +1
	analizar_qtd()
	$botão1.disabled =true

func _on_botão_2_button_down() -> void:
	botoesPrecionados.append(2)
	qtd = qtd +1
	analizar_qtd()
	$botão2.disabled =true

func _on_botão_3_button_down() -> void:
	erro = erro + 1
	var texto_aviso = "esse item não gasta agua"
	PopupManager.mostrar(texto_aviso)
	$botão3.disabled  = true


func _on_botão_4_button_down() -> void:
	botoesPrecionados.append(3)
	qtd = qtd +1
	analizar_qtd()
	$botão4.disabled =true


func _on_botão_5_button_down() -> void:
	botoesPrecionados.append(4)
	qtd = qtd +1
	analizar_qtd()
	$botão5.disabled =true


func _on_botão_6_button_down() -> void:
	botoesPrecionados.append(5)
	qtd = qtd +1
	analizar_qtd()
	$botão6.disabled =true


func _on_botão_7_button_down() -> void:
	erro = erro + 1
	var texto_aviso = "esse item não gasta agua"
	PopupManager.mostrar(texto_aviso)
	$botão7.disabled = true


func _on_botão_8_button_down() -> void:
	botoesPrecionados.append(6)
	qtd = qtd +1
	analizar_qtd()
	$botão8.disabled = true

func analizar_qtd() -> void:
	if qtd == 3:
		ir_prox_etapa()
		
# No script da FASE 1

# ...

func ir_prox_etapa() -> void:
	
	# 1. SALVAR OS DADOS NO AUTOLOAD (DadosDoJogo)
	# Copia o array de acertos da Fase 1 para a variável global
	DadosDoJogo.botoes_corretos_fase1 = botoesPrecionados
	
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
