extends Button

# Crie uma variável pública para guardar o texto.
var texto_de_ajuda: String = "Nenhuma ajuda definida para esta tela."

func _on_pressed():
	# Quando o botão for pressionado, mostre o texto que está guardado na variável.
	PopupManager.mostrar(texto_de_ajuda)
