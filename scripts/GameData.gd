extends Node

# VARIÁVEIS PARA ARMAZENAR OS DADOS DA FASE 1
var botoes_corretos_fase1 = [] # Para o array de acertos
var erros_acumulados = 0       # Para o contador de erros
var erro_etapa2 = 0
var erro_etapa3 = 0
var erro_etapa4 = 0
var erro_fase2 = 0
var pontos_fase2 = 0
var valores = []  # array para os valores das imagens
var flag1 = 0
var flag2 = 0
var nome_jogador: String = ""

func reset() -> void:
	botoes_corretos_fase1.clear()
	valores.clear()
	erros_acumulados = 0
	erro_etapa2 = 0
	erro_etapa3 = 0
	erro_etapa4 = 0
	erro_fase2 = 0
	pontos_fase2 = 0
	flag1 = 0
	flag2 = 0
	nome_jogador =""
