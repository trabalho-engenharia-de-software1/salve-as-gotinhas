extends Control

@onready var cb1 = $CheckButton
@onready var cb3 = $CheckButton2
@onready var cb2 = $CheckButton3

var is_updating := false

func _ready():
	match DadosDoJogo.dific:
		1:
			cb1.button_pressed = true
		2:
			cb2.button_pressed = true
		3:
			cb3.button_pressed = true
	cb1.toggled.connect(_on_toggled.bind(cb1))
	cb2.toggled.connect(_on_toggled.bind(cb2))
	cb3.toggled.connect(_on_toggled.bind(cb3))


func _on_toggled(pressed: bool, activated_button: BaseButton):
	if is_updating:
		return

	# Impede desmarcar o botão ativo clicando nele mesmo
	if not pressed:
		is_updating = true
		activated_button.button_pressed = true
		is_updating = false
		return

	# Caso tenha sido pressionado normalmente, troca o ativo
	is_updating = true

	for cb in [cb1, cb2, cb3]:
		if cb != activated_button:
			cb.button_pressed = false

	is_updating = false
	if pressed:
		# AQUI é onde você muda o valor conforme o botão selecionado
		if activated_button == cb1:
			DadosDoJogo.dific = 1
		elif activated_button == cb2:
			DadosDoJogo.dific = 2
		elif activated_button == cb3:
			DadosDoJogo.dific = 3

	print("Valor atual:", DadosDoJogo.dific)
