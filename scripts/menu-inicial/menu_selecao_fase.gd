extends Control

@onready var iniciar_fase1 = $iniciarfase1
@onready var botao_ajuda = $HelpLayer/botaoAjuda
@onready var iniciar_fase2 = $iniciarfase2

func _ready() -> void:
	await get_tree().process_frame
	
	var lista_de_passos = [
		
		# Exemplo 1: Destaque automático no Botão A
		{
			"tipo": "alvo_automatico",
			"alvo": iniciar_fase1,
			"texto": "Clique para jogar a fase 1!",
			"audio":preload("res://narracao/menu/clique para jogar a fase 1.wav")
		},
		{
			"tipo": "alvo_automatico",
			"alvo": iniciar_fase2,
			"texto": "Clique para jogar a fase 2!",
			"audio":preload("res://narracao/menu/clique para jogar a fase 2.wav")
		}
	]
	botao_ajuda.habilitar_ajuda_com_passos(lista_de_passos)
	if DadosDoJogo.flag1 == 1 and DadosDoJogo.flag2 == 1:
		sair()

func _on_iniciarfase_1_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fase1/fase1_cena.tscn")

func _on_iniciarfase_2_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fase2/fase2_cena.tscn")

func sair() -> void:
	print("deu boa")
	confg()
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")
	
func confg() -> void:
	DadosDoJogo.reset()


func _on_iniciarsomando_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/relatorio/relatorio_somando.tscn")


func _on_iniciarsubtraindo_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/relatorio/relatorio_subtraindo.tscn")
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")
