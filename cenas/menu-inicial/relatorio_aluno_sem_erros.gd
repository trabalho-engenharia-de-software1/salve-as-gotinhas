extends Node2D

func _ready() -> void:
	var texto_final = ""  # acumula o texto de todas as linhas
	texto_final = "%.0f" %(RelatorioDados.tempo1[RelatorioDados.qtd -1] +RelatorioDados.tempo2[RelatorioDados.qtd -1]+ RelatorioDados.tempo3[RelatorioDados.qtd -1]+RelatorioDados.tempo4[RelatorioDados.qtd -1])
	$Label9.text = texto_final  # aplica tudo de uma vez
	texto_final = "%.0f" %(RelatorioDados.tempo5[RelatorioDados.qtd -1])
	$Label8.text = texto_final 
	texto_final = str(RelatorioDados.pontos_fase2[RelatorioDados.qtd -1])
	$Label7.text = texto_final 
