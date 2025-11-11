# Script: sensor_de_narracao.gd
# IMPORTANTE: Este script deve ser anexado a um nó Area2D
extends Area2D

# --- Variável de Configuração ---
# No Inspetor, você vai arrastar o áudio para este campo
@export var meu_som_de_narracao: AudioStream

# --- Nosso Timer de "Atraso" ---
var hover_timer: Timer
# Ajuste este valor (em segundos) se quiser um delay maior ou menor
const HOVER_DELAY = 0.2

func _ready():
	# 1. Conecta os sinais da PRÓPRIA Area2D
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	
	# 2. Configura o timer
	hover_timer = Timer.new()
	hover_timer.wait_time = HOVER_DELAY
	hover_timer.one_shot = true
	add_child(hover_timer)
	
	# 3. Conecta o timer à função de "tocar"
	hover_timer.timeout.connect(_on_hover_timer_timeout)

# Quando o mouse entra...
func _on_mouse_entered():
	# ...nós ligamos o timer.
	hover_timer.start()

# Quando o mouse sai...
func _on_mouse_exited():
	# ...nós paramos o timer (antes que ele termine)
	hover_timer.stop()
	# E mandamos o "chefe" parar o nosso som (o jeito "educado")
	NarradorGlobal.parar_narracao_se_for(meu_som_de_narracao)
	
# Esta função SÓ é chamada se o mouse ficar parado por 0.2 segundos
func _on_hover_timer_timeout():
	# O mouse "descansou" no item. AGORA sim, tocamos o som.
	NarradorGlobal.tocar_narracao(meu_som_de_narracao)
