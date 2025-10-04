@tool # Permite que o script rode no editor para vermos as mudanças na hora
extends CheckButton

# --- Variáveis Configuráveis no Editor ---

# O custo de água e o número de gotas a serem exibidas
@export var custo_e_gotas: int = 1:
	set(valor):
		custo_e_gotas = valor
		if is_inside_tree():
			_atualizar_visual_gotas()

# O ícone principal (torneira, chuveiro, etc.)
@export var icone: Texture2D:
	set(valor):
		icone = valor
		if is_inside_tree():
			self.icon = valor # 'self.icon' é a propriedade do CheckButton

# --- Lógica Interna ---

func _ready():
	# Garante que os visuais estejam corretos quando o jogo começa
	_atualizar_visual_gotas()
	self.icon = icone

# Função para mostrar/esconder as gotinhas
func _atualizar_visual_gotas():
	# Checa se o nó MostradorDeGotas existe para evitar erros
	var mostrador = find_child("Gotas")
	if not mostrador:
		return

	var gotas = mostrador.get_children()
	for i in range(gotas.size()):
		if i < custo_e_gotas:
			gotas[i].visible = true
		else:
			gotas[i].visible = false
