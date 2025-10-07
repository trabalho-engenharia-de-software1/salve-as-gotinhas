extends Button

func _on_pressed():
	if PopupManager:
		PopupManager.mostrar("Infelizmente sem essa funcao ainda :(")
	else:
		push_error("!!! ERRO: PopupManager (Autoload) não foi encontrado.")
