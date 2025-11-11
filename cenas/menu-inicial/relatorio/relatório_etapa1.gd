extends Label

func _ready() -> void:
	var texto_final = ""  # acumula o texto de todas as linhas
	
	for i in range(RelatorioDados.qtd):
		texto_final += str(RelatorioDados.erros_acumulados[i]) + "           " + "%.2f" %RelatorioDados.tempo1[i] + "s" + "\n\n"
	
	text = texto_final  # aplica tudo de uma vez
