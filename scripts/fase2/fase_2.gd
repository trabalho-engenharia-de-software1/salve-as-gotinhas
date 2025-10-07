extends Node2D

var agua_maxima: float = 100.0
var agua_atual: float = 100.0

@onready var reservatorio = $Reservatorio
@onready var container_de_opcoes = $BoxOpcoes

func _ready():
	reservatorio.atualizar_nivel(agua_atual, agua_maxima)
	
	# Em vez de pegar os filhos de um container, pedimos à árvore da cena
	# para nos dar TODOS os nós que estão no grupo 'opcoes_clicaveis'.
	var todas_as_opcoes = get_tree().get_nodes_in_group("opcoes_clicaveis")
	
	# Este loop SÓ vai passar pelos nós corretos (seus OpcaoGasto), ignorando completamente as Sprites!
	for opcao in todas_as_opcoes:
		# Conecta o sinal 'toggled' de cada opção à nossa função de lógica.
		opcao.toggled.connect(_on_opcao_toggled.bind(opcao))

# Função chamada quando QUALQUER OpcaoGasto é clicada
func _on_opcao_toggled(foi_marcado: bool, opcao_clicada):
	# Pega o custo da opção específica que foi clicada
	var custo = opcao_clicada.custo_e_gotas
	
	# Se a caixa foi marcada, gasta água
	if foi_marcado:
		agua_atual -= 10 * custo
	# Se foi desmarcada, devolve a água
	else:
		agua_atual += 10 * custo
	
	# Garante que a água não saia dos limites
	agua_atual = clamp(agua_atual, 0.0, agua_maxima)
	
	# Manda o reservatório atualizar seu visual
	reservatorio.atualizar_nivel(agua_atual, agua_maxima)
	
	if agua_atual <= 0:
		# Se a água acabou, chamamos o popup!
		PopupManager.mostrar("A ÁGUA ACABOU!")
		# !!!!
		# PRECISA REINICIAR A FASE AQUI!!!!!!!!
		# !!!!!
