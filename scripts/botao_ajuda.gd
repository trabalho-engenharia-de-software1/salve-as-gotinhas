extends Button

var passos_de_ajuda: Array = []
var passo_atual: int = 0
var ajuda_ativa: bool = false
var tour_timer: Timer

# Removemos o audio_player interno e usamos o Global
@onready var som_hover: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var area: Area2D = $Area2D

func _ready():
	area.input_pickable = true
	if area:
		area.mouse_entered.connect(_on_area_mouse_entered)
		
	self.pressed.connect(_on_pressed)
	
	tour_timer = Timer.new()
	tour_timer.wait_time = 4.5
	tour_timer.one_shot = true
	add_child(tour_timer)
	tour_timer.timeout.connect(_mostrar_proximo_passo)
	
	# Removemos a criação do audio_player local, não precisa mais.

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
	
	if passo_info["tipo"] == "alvo_automatico":
		var no_alvo_atual = passo_info["alvo"]
		if not is_instance_valid(no_alvo_atual):
			_parar_tour()
			return
		PopupManager.mostrar_ajuda_contextual(no_alvo_atual, texto_atual)
	
	elif passo_info["tipo"] == "alvo_manual":
		var pos_centro = passo_info["pos_centro_pixels"]
		var raios = passo_info["raios_pixels"]
		PopupManager.mostrar_ajuda_manual(pos_centro, raios, texto_atual)
	
	# --- AQUI ESTÁ A MUDANÇA ---
	if passo_info.has("audio") and passo_info["audio"] != null:
		# Chamamos o NarradorGlobal com TRUE (Prioridade Alta!)
		# Isso vai calar qualquer som de hover imediatamente.
		NarradorGlobal.tocar_narracao(passo_info["audio"], true)
	
	passo_atual += 1
	tour_timer.start()

func _on_area_mouse_entered() -> void:
	# O som de hover do próprio botão de ajuda continua local (opcional)
	if som_hover and not som_hover.playing:
		som_hover.play()
		
func _parar_tour():
	ajuda_ativa = false
	passo_atual = 0
	tour_timer.stop()
	PopupManager.esconder_ajuda()
	# Opcional: Parar o áudio quando fecha o tour
	NarradorGlobal.tocar_narracao(null)

func iniciar_tour_automatico():
	if ajuda_ativa: return
	if passos_de_ajuda.is_empty(): return
	ajuda_ativa = true
	passo_atual = 0
	_mostrar_proximo_passo()
