# Script: NarradorGlobal.gd (Autoload)
extends Node

var narrador: AudioStreamPlayer
var tocando_algo_importante: bool = false 

func _ready():
	narrador = AudioStreamPlayer.new()
	narrador.finished.connect(_on_audio_finished)
	add_child(narrador)
	
	# Começa com o "policiamento" desligado para economizar processamento
	set_process(false)

func tocar_narracao(som_para_tocar: AudioStream, prioridade_alta: bool = false):
	
	if som_para_tocar == null:
		if not tocando_algo_importante:
			narrador.stop()
		return

	# REGRA 1: Se o hover tenta falar por cima de algo importante, ignoramos.
	if tocando_algo_importante and not prioridade_alta:
		return 

	# REGRA 2: Se é PRIORIDADE ALTA (Popup/Ajuda)...
	if prioridade_alta:
		tocando_algo_importante = true
		
		# ATIVA O MODO POLICIAL:
		# Isso vai rodar a função _process() 60x por segundo
		# para garantir que NINGUÉM mais toque nada.
		silenciar_o_mundo_inteiro() 
		set_process(true)
	
	if narrador.stream == som_para_tocar and narrador.playing:
		return
		
	narrador.stop()
	narrador.stream = som_para_tocar
	narrador.play()

func parar_narracao_se_for(som_que_pediu_para_parar: AudioStream):
	if tocando_algo_importante:
		return
	if narrador.stream == som_que_pediu_para_parar:
		narrador.stop()

func _on_audio_finished():
	# O áudio importante acabou.
	tocando_algo_importante = false
	# Desativa o modo policial. Os outros sons podem voltar a funcionar.
	set_process(false)

# --- A FUNÇÃO POLICIAL ---
# Como ativamos o set_process(true), isso roda a cada frame
func _process(_delta):
	if tocando_algo_importante:
		# Verifica se algum "intruso" começou a tocar neste milissegundo e corta ele
		silenciar_o_mundo_inteiro()

# Função que busca e para todos os sons
func silenciar_o_mundo_inteiro():
	var cena_atual = get_tree().current_scene
	if not cena_atual: return

	# 1. Caça TODOS os AudioStreamPlayer (simples)
	var players_comuns = cena_atual.find_children("*", "AudioStreamPlayer", true, false)
	for p in players_comuns:
		# Se o player estiver tocando E NÃO FOR o nosso narrador
		if p != narrador and p.playing:
			p.stop() 
			
	# 2. Caça TODOS os AudioStreamPlayer2D
	var players_2d = cena_atual.find_children("*", "AudioStreamPlayer2D", true, false)
	for p in players_2d:
		if p.playing:
			p.stop() 
