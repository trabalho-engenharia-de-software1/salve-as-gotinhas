extends Node2D

var pressed_buttons = []  # aqui vamos armazenar os botões apertados

func _ready():
	for button in get_children():
		if button is Button:
			button.connect("pressed", Callable(self, "_on_button_pressed").bind(button))

func _on_button_pressed(button):
	if button not in pressed_buttons:
		pressed_buttons.append(button)  # armazena o botão apertado
		button.disabled = true
		print("Botões apertados:", pressed_buttons.size())

	if pressed_buttons.size() >= 3:
		_next_phase()

func _next_phase():
	print("Indo para a próxima parte da fase!")
	for button in get_children():
		if button is Button:
			button.visible = false
