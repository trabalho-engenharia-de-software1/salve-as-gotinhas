# Nome do arquivo: NarradorGlobal.gd
extends Node

# Esta variável vai guardar o nosso "alto-falante"
var narrador: AudioStreamPlayer

func _ready():
	# 1. Cria o nó do alto-falante em tempo real
	narrador = AudioStreamPlayer.new()
	# 2. Adiciona ele como filho deste Autoload
	# Isso garante que ele exista na árvore de cenas e possa tocar som
	add_child(narrador)

# Esta é a nossa função "controladora de tráfego"
# Qualquer item do jogo pode chamar esta função
func tocar_narracao(som_para_tocar: AudioStream):
	
	# Se o som for 'null' (do sinal 'mouse_exited'), paramos de tocar
	if som_para_tocar == null:
		narrador.stop()
		return

	# Se já estivermos tocando o mesmo som, não fazemos nada
	if narrador.stream == som_para_tocar and narrador.playing:
		return
	
	# Se for um som novo, paramos o antigo e tocamos o novo
	narrador.stop()
	narrador.stream = som_para_tocar
	narrador.play()
	
func parar_narracao_se_for(som_que_pediu_para_parar: AudioStream):
	if narrador.stream == som_que_pediu_para_parar:
		narrador.stop()
