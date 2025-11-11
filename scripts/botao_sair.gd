# Anexado ao nó raiz "BotaoSair" (que é um Node2D)
extends Node2D

@export var meu_som_de_narracao: AudioStream

@onready var botao: Button = $sair
	
var hover_timer: Timer
const HOVER_DELAY = 0.5

func _ready():
	# 1. Conecta o sinal de "clique" do botão
	botao.pressed.connect(sair) # Conecta à sua função 'sair()'
	
	# 2. Conecta os sinais de mouse DO PRÓPRIO BOTÃO
	# (Nós não precisamos mais da 'area')
	botao.mouse_entered.connect(_on_area_mouse_entered)
	botao.mouse_exited.connect(_on_area_mouse_exited)
	
	# 3. Configura o timer
	hover_timer = Timer.new()
	hover_timer.wait_time = HOVER_DELAY
	hover_timer.one_shot = true
	add_child(hover_timer)
	
	# 4. Conecta o timer à função de "tocar"
	hover_timer.timeout.connect(_on_hover_timer_timeout)

# --- O RESTO DO SEU SCRIPT ESTÁ PERFEITO E NÃO MUDA ---

func sair() -> void:
	get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")
	
func _on_area_mouse_entered():
	hover_timer.start()

func _on_area_mouse_exited():
	hover_timer.stop()
	NarradorGlobal.tocar_narracao(null)
	
func _on_hover_timer_timeout():
	NarradorGlobal.tocar_narracao(meu_som_de_narracao)
