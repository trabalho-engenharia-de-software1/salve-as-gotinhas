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
var tempo1 = 0
var tempo2 = 0
var tempo3 = 0
var tempo4 = 0
var tempo5 = 0 
var dific = 1

func reset() -> void:
	RelatorioDados.nome_jogador.append(DadosDoJogo.nome_jogador)
	if flag1 == 1:
		RelatorioDados.erros_acumulados.append(DadosDoJogo.erros_acumulados)
		RelatorioDados.erro_etapa2.append(DadosDoJogo.erro_etapa2)
		RelatorioDados.erro_etapa3.append(DadosDoJogo.erro_etapa3)
		RelatorioDados.erro_etapa4.append(DadosDoJogo.erro_etapa4)
		RelatorioDados.tempo1.append(DadosDoJogo.tempo1)
		RelatorioDados.tempo2.append(DadosDoJogo.tempo2)
		RelatorioDados.tempo3.append(DadosDoJogo.tempo3)
		RelatorioDados.tempo4.append(DadosDoJogo.tempo4)
	else:
		RelatorioDados.erros_acumulados.append(0)
		RelatorioDados.erro_etapa2.append(0)
		RelatorioDados.erro_etapa3.append(0)
		RelatorioDados.erro_etapa4.append(0)
		RelatorioDados.tempo1.append(0)
		RelatorioDados.tempo2.append(0)
		RelatorioDados.tempo3.append(0)
		RelatorioDados.tempo4.append(0)
	if flag2 == 0:
		RelatorioDados.erro_fase2.append(DadosDoJogo.erro_fase2)
		RelatorioDados.pontos_fase2.append(DadosDoJogo.pontos_fase2)
		RelatorioDados.tempo5.append(DadosDoJogo.tempo5)
	else :
		RelatorioDados.erro_fase2.append(0)
		RelatorioDados.pontos_fase2.append(0)
		RelatorioDados.tempo5.append(0)
	RelatorioDados.qtd =RelatorioDados.qtd + 1
	tempo5 = 0 
	tempo4 = 0
	tempo3 = 0
	tempo2 = 0
	tempo1 = 0
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
	
