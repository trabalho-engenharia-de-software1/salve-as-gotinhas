# Nome do arquivo: item_narrado.gd
extends Label

# A variável "sabor" que vai aparecer no Inspetor
@export var meu_som_de_narracao: AudioStream

@onready var area: Area2D = $Area2D
var hover_timer: Timer

const HOVER_DELAY = 0.5

func _ready():
	area.mouse_entered.connect(_on_area_mouse_entered)
	area.mouse_exited.connect(_on_area_mouse_exited)
	
	# Configura o timer para o som
	hover_timer = Timer.new()
	hover_timer.wait_time = HOVER_DELAY
	hover_timer.one_shot = true
	add_child(hover_timer)
	
	# Conecta o timer à função de "tocar"
	hover_timer.timeout.connect(_on_hover_timer_timeout)

func _on_area_mouse_entered():
	hover_timer.start()

func _on_area_mouse_exited():
	# Para o timer
	hover_timer.stop()
	# E manda parar qualquer som que esteja tocando
	NarradorGlobal.tocar_narracao(null)
	
# Esta função so é chamada se o mouse ficar parado por 0.2 segundos
func _on_hover_timer_timeout():
	# Agora sim, toca o som.
	NarradorGlobal.tocar_narracao(meu_som_de_narracao)
