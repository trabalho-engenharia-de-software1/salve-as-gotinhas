extends Button

var passos_de_ajuda: Array = []
var passo_atual: int = 0
var ajuda_ativa: bool = false
var tour_timer: Timer
var audio_player: AudioStreamPlayer
@onready var som_hover: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var area: Area2D = $Area2D



func _ready():
	area.input_pickable = true
	if area:
		area.mouse_entered.connect(_on_area_mouse_entered)
	else:
		push_error("⚠️ Area2D não encontrada! Verifique a hierarquia.")
	

	self.pressed.connect(_on_pressed)
	
	tour_timer = Timer.new()
	tour_timer.wait_time = 4.5
	tour_timer.one_shot = true
	add_child(tour_timer)
	tour_timer.timeout.connect(_mostrar_proximo_passo)
	
	# A CONEXÃO 'PopupManager.tour_cancelado_pelo_popup.connect' FOI REMOVIDA
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
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
	if passo_info.has("audio") and passo_info["audio"] != null:
		audio_player.stream = passo_info["audio"]
		audio_player.play()
	
	passo_atual += 1
	tour_timer.start()

func _on_area_mouse_entered() -> void:
	print("Mouse entrou em:", name)
	if som_hover and not som_hover.playing:
		som_hover.play()
		
func _parar_tour():
	ajuda_ativa = false
	passo_atual = 0
	tour_timer.stop()
	PopupManager.esconder_ajuda()

func iniciar_tour_automatico():
	# Verifica se a ajuda já está ativa (para não bugar)
	if ajuda_ativa:
		return
		
	# Verifica se o tour está pronto (se a lista de passos não está vazia)
	if passos_de_ajuda.is_empty():
		# (Não mostra o erro "Nenhuma ajuda configurada" automaticamente)
		return
	
	print("Iniciando tour de ajuda AUTOMÁTICO...")
	ajuda_ativa = true
	passo_atual = 0
	_mostrar_proximo_passo() # Mostra o primeiro passo
