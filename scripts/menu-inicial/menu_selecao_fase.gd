extends Control

@onready var botao_ajuda = $HelpLayer/botaoAjuda # Verifique se o caminho está correto

# Pega a referência para o NÓ que você quer destacar
@onready var botao_fase_1 = $iniciarfase1
@onready var botao_fase_2 = $iniciarfase2

func _ready() -> void:
	# Espera 1 frame para garantir que 'botao_de_ajuda' e 'botao_jogar' carregaram
	await get_tree().process_frame

	var lista_de_passos = [
		{
			"tipo": "alvo_automatico",
			"alvo": botao_fase_1,
			"texto": "Clique aqui para jogar a Fase 1!"
		},
		{
			"tipo": "alvo_automatico",
			"alvo": botao_fase_2,
			"texto": "Clique aqui para jogar a Fase 2."
		}
	]
		
	# Entrega a lista de passos para o script do botão de ajuda
	botao_ajuda.habilitar_ajuda_com_passos(lista_de_passos)

func _on_iniciarfase_1_pressed() -> void:
	print("botao iniciar fase 1 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase1/fase1_cena.tscn")


func _on_iniciarfase_2_pressed() -> void:
	print("botao iniciar fase 2 pressionado")
	get_tree().change_scene_to_file("res://cenas/fase2/fase2_cena.tscn")
