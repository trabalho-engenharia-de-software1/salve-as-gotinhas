extends CanvasLayer

@onready var texto_popup: Label = $color/caixaTexto/VBoxContainer/texto
@onready var botao_ok: Button = $color/caixaTexto/botao
@onready var fundo: ColorRect = $color

func _ready():
	layer = 1000  # fica acima de tudo
	botao_ok.pressed.connect(esconder_popup)
	hide()

func mostrar_popup(texto: String):
	texto_popup.text = texto
	await get_tree().process_frame
	show()

func esconder_popup():
	hide()
