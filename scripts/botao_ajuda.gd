extends Button

var passos_de_ajuda: Array = []
var passo_atual: int = 0
var ajuda_ativa: bool = false
var tour_timer: Timer

func _ready():
	self.pressed.connect(_on_pressed)
	
	tour_timer = Timer.new()
	tour_timer.wait_time = 3.0
	tour_timer.one_shot = true
	add_child(tour_timer)
	tour_timer.timeout.connect(_mostrar_proximo_passo)
	
	# A CONEXÃO 'PopupManager.tour_cancelado_pelo_popup.connect' FOI REMOVIDA

# --- O resto do script continua EXATAMENTE IGUAL ---

func habilitar_ajuda_com_passos(passos: Array):
	self.passos_de_ajuda = passos
	self.disabled = false 

func _on_pressed():
	if ajuda_ativa:
		_parar_tour()
	else:
		if passos_de_ajuda.is_empty():
			PopupManager.mostrar("Nenhuma ajuda configurada.")
			return
		
		print("Iniciando tour de ajuda...")
		ajuda_ativa = true
		passo_atual = 0
		_mostrar_proximo_passo()

func _mostrar_proximo_passo():
	if not ajuda_ativa: return
	if passo_atual >= passos_de_ajuda.size():
		_parar_tour()
		return

	var passo_info = passos_de_ajuda[passo_atual]
	var texto_atual = passo_info["texto"]
	
	# --- A NOVA LÓGICA DE TIPO ---
	
	# Checa se o passo é do tipo "automático" (baseado em um nó)
	if passo_info["tipo"] == "alvo_automatico":
		var no_alvo_atual = passo_info["alvo"]
		if not is_instance_valid(no_alvo_atual):
			print("ERRO: Alvo automático não encontrado.")
			_parar_tour()
			return
		PopupManager.mostrar_ajuda_contextual(no_alvo_atual, texto_atual)
	
	# Checa se o passo é do tipo "manual" (baseado em coordenadas)
	elif passo_info["tipo"] == "alvo_manual":
		var pos_centro = passo_info["pos_centro_pixels"]
		var raios = passo_info["raios_pixels"]
		PopupManager.mostrar_ajuda_manual(pos_centro, raios, texto_atual)
	
	# --- FIM DA NOVA LÓGICA ---

	passo_atual += 1
	tour_timer.start()

func _parar_tour():
	ajuda_ativa = false
	passo_atual = 0
	tour_timer.stop()
	PopupManager.esconder_ajuda()
