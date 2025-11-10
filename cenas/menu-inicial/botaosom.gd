extends Button

# A variável "sabor" que vai aparecer no Inspetor
@export var meu_som_de_narracao: AudioStream

@onready var area: Area2D = $Area2D
var hover_timer: Timer

# Define o tempo de "delay". 0.2 segundos é um bom começo.
const HOVER_DELAY = 0.5

func _ready():
	# 1. Verifica se a área foi encontrada
	if not area:
		push_error("ERRO em " + name + ": Nó 'Area2D' não encontrado como filho!")
		return
		
	# 2. Conecta os sinais da Area2D
	area.mouse_entered.connect(_on_area_mouse_entered)
	area.mouse_exited.connect(_on_area_mouse_exited)
	
	# 3. Configura o timer
	hover_timer = Timer.new()
	hover_timer.wait_time = HOVER_DELAY
	hover_timer.one_shot = true
	add_child(hover_timer)
	
	# 4. Conecta o timer à função de "tocar"
	hover_timer.timeout.connect(_on_hover_timer_timeout)

# Quando o mouse entra...
func _on_area_mouse_entered():
	# ...nós NÃO tocamos o som. Nós apenas LIGAMOS o timer.
	hover_timer.start()

# Quando o mouse sai...
func _on_area_mouse_exited():
	# ...nós PARAMOS o timer (antes que ele termine)
	hover_timer.stop()
	# E mandamos o "chefe" global parar qualquer som que esteja tocando
	NarradorGlobal.tocar_narracao(null)
	
# Esta função SÓ é chamada se o mouse ficar parado por 0.2 segundos
func _on_hover_timer_timeout():
	# O mouse "descansou" no item. AGORA sim, tocamos o som.
	NarradorGlobal.tocar_narracao(meu_som_de_narracao)
