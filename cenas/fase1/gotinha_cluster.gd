# res://scripts/gotinha_cluster.gd
extends Area2D

@export var quantidade: int = 0   # número de gotinhas
@export var objeto_id: int = 0    # id do objeto (1..6)

# Dicionários simples pra mapear sons
const AUDIOS_QTDE = {
	3: preload("res://narracao/gotinhas/positivo/3.wav"),
	4: preload("res://narracao/gotinhas/positivo/4.wav"),
	5: preload("res://narracao/gotinhas/positivo/5.wav"),
	6: preload("res://narracao/gotinhas/positivo/6.wav"),
	7: preload("res://narracao/gotinhas/positivo/7.wav"),
	8: preload("res://narracao/gotinhas/positivo/8.wav"),
	9: preload("res://narracao/gotinhas/positivo/9.wav"),
	10: preload("res://narracao/gotinhas/positivo/10.wav"),
}

const AUDIOS_OBJ = {
	1: preload("res://narracao/objetos/chuveiro.wav"),
	2: preload("res://narracao/objetos/mangueira .wav"),
	3: preload("res://narracao/objetos/regador.wav"),
	4: preload("res://narracao/objetos/descarga.wav"),
	5: preload("res://narracao/objetos/torneira.wav"),
	6: preload("res://narracao/objetos/bebedouro.wav"),
}

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	# toca primeiro o som da quantidade
	var som_qtde = AUDIOS_QTDE.get(quantidade)
	if som_qtde:
		NarradorGlobal.tocar_narracao(som_qtde)
	
	# aguarda terminar e toca o som do objeto (opcional)
	await NarradorGlobal.narrador.finished
	var som_obj = AUDIOS_OBJ.get(objeto_id)
	if som_obj:
		NarradorGlobal.tocar_narracao(som_obj)

func _on_mouse_exited():
	NarradorGlobal.tocar_narracao(null)
