# Anexado ao nó raiz "MedidorTotal"
extends Node2D

@onready var container_gotas = $Gotas
@onready var label_numero = $LabelNumero

# Esta é a ÚNICA função que ele tem.
func atualizar_medidor(valor_atual: float, valor_maximo: float):
	
	# 1. Converte o valor da água para um número de gotas
	# A função floor() arredonda para baixo (ex: 97.0 / 10 = 9.7, que vira 9.0)
	var gotas_para_mostrar = floor(valor_atual / 10.0) 
	
	# --- AQUI ESTÁ A CORREÇÃO ---
	
	# 2. Atualiza o número (Label)
	# Em vez de 'str(valor_atual)', nós usamos a variável 'gotas_para_mostrar'.
	# Usamos int() para garantir que ele mostre "10" ou "9", e não "10.0" ou "9.0".
	label_numero.text = str(int(gotas_para_mostrar))
	
	# --- FIM DA CORREÇÃO ---
	
	# 3. Mostra/esconde as sprites de gota
	var gotas = container_gotas.get_children()
	for i in range(gotas.size()):
		if i < gotas_para_mostrar:
			gotas[i].visible = true
		else:
			gotas[i].visible = false
