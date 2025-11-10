extends Control

func _ready() -> void:
	if DadosDoJogo.flag1 == 1 and DadosDoJogo.flag2 == 1:
		sair()

func _on_iniciarfase_1_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fase1/fase1_cena.tscn")

func _on_iniciarfase_2_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fase2/fase2_cena.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")

func sair() -> void:
	confg()
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")
	
func confg() -> void:
	RelatorioDados.erros_acumulados.append(DadosDoJogo.erros_acumulados)
	RelatorioDados.erro_etapa2.append(DadosDoJogo.erro_etapa2)
	RelatorioDados.erro_etapa3.append(DadosDoJogo.erro_etapa3)
	RelatorioDados.erro_etapa4.append(DadosDoJogo.erro_etapa4)
	RelatorioDados.erro_fase2.append(DadosDoJogo.erro_fase2)
	RelatorioDados.pontos_fase2.append(DadosDoJogo.pontos_fase2)
	RelatorioDados.nome_jogador.append(DadosDoJogo.nome_jogador)
	DadosDoJogo.reset()
