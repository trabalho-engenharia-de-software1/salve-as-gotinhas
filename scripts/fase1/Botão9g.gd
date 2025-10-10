@tool
extends Node2D

# -----------------------------------------------------------------------------
# Variáveis e Exportação
# -----------------------------------------------------------------------------

# Prefixo de nome que todas as gotas compartilham (ex: gotinha1, gotinha2)
const GOTA_PREFIXO = "gotinha"

# A quantidade de gotas que devem estar visíveis.
@export var quantidade: int = 5:
	set(value):
		# 1. Garante que o valor está dentro dos limites válidos.
		var total_gotas = _get_todas_gotas().size()
		var new_value = clamp(int(value), 0, total_gotas)
		
		# 2. Só atualiza a cena se o valor mudou.
		if quantidade != new_value:
			quantidade = new_value
			# 3. Atualiza a visibilidade das gotas.
			if is_inside_tree():
				_atualizar_visibilidade_gotas()
				print(f"[Gotas] Setter ajustado para: {quantidade}/{total_gotas}")

# Armazena a referência a todos os nós de gotas (Gotinha1, Gotinha2, ...)
# Usamos @onready para garantir que os nós já estejam na árvore.
@onready var todas_as_gotas: Array[Node] = _encontrar_gotas_na_cena()

# -----------------------------------------------------------------------------
# Funções de Inicialização e Lógica
# -----------------------------------------------------------------------------

func _ready():
	# Aplica o valor inicial (do Inspector) ao entrar na cena.
	_atualizar_visibilidade_gotas()
	# Tenta conectar com um controlador UI (Slider/SpinBox/etc)
	_conectar_selector()
	print(f"[Gotas] Prontas. Total de gotas encontradas: {todas_as_gotas.size()}")

## Encontra todas as gotas usando o padrão de nome (gotinha*)
func _encontrar_gotas_na_cena() -> Array[Node]:
	# find_children:
	# 1º argumento: Padrão do nome. "*" significa qualquer coisa. Ex: "gotinha*"
	# 2º argumento: Tipo (não necessário, usamos a verificação visual depois).
	# 3º argumento: Busca recursiva (false, pois são filhas diretas).
	# 4º argumento: Busca por nodes que são "owned" (true é o default e mais seguro).
	var gotas = find_children(GOTA_PREFIXO + "*", "Node", false, true)
	
	# Filtra e Ordena:
	# 1. Remove nós que não são visuais (apenas para segurança).
	gotas = gotas.filter(func(n): return n is Node2D or n is Control)
	
	# 2. Ordena as gotas por nome (para que gotinha1 venha antes de gotinha10)
	# O sort_custom precisa de um Callable para comparar.
	gotas.sort_custom(Callable(self, "_ordenar_gotas_por_nome"))
	
	return gotas

## Função de comparação para o sort_custom, garantindo ordem numérica correta.
func _ordenar_gotas_por_nome(a: Node, b: Node) -> bool:
	# Extrai o número do final do nome (ex: "gotinha5" -> 5)
	var num_a = a.name.lstrip(GOTA_PREFIXO).to_int()
	var num_b = b.name.lstrip(GOTA_PREFIXO).to_int()
	
	# Retorna true se 'a' deve vir antes de 'b'
	return num_a < num_b

## Retorna o array de gotas já encontrado e ordenado.
func _get_todas_gotas() -> Array[Node]:
	# Garante que o array está populado, especialmente útil para @tool
	if todas_as_gotas.is_empty():
		todas_as_gotas = _encontrar_gotas_na_cena()
	return todas_as_gotas

## Função principal que controla quais nós filhos serão visíveis.
func _atualizar_visibilidade_gotas():
	var gotas_encontradas = _get_todas_gotas()
	
	if gotas_encontradas.is_empty():
		return
	
	for i in range(gotas_encontradas.size()):
		var gota = gotas_encontradas[i]
		
		# A gota deve ser visível se o índice (i) for menor que a 'quantidade'.
		# i=0 é a primeira gota (gotinha1), i=1 é a segunda (gotinha2), etc.
		gota.visible = i < quantidade
		# print(f"  -> {gota.name}: {'VISÍVEL' if gota.visible else 'OCULTA'}") # Debug detalhado

# -----------------------------------------------------------------------------
# Conexão Automática do Seletor UI (Reutilizada e Segura)
# -----------------------------------------------------------------------------

func _conectar_selector():
	var selector_classes = [SpinBox, HSlider, OptionButton]
	var selector = null
	
	var nodes_to_check = get_children() + (get_parent().get_children() if is_instance_valid(get_parent()) else [])
	
	for n in nodes_to_check:
		for class_ref in selector_classes:
			if n.is_class_of(class_ref.get_class()):
				selector = n
				break
		if selector:
			break
			
	if selector:
		var callable = Callable(self, "_on_selector_value_changed")
		if not selector.is_connected("value_changed", callable):
			selector.connect("value_changed", callable)
			print(f"[Gotas] Selector '{selector.name}' conectado.")
			
			# Configura o Max Value do seletor com o número total de gotas
			if selector is SpinBox or selector is HSlider:
				selector.max_value = _get_todas_gotas().size()
	else:
		print("[Gotas] Nenhum seletor UI encontrado para conexão automática.")

func _on_selector_value_changed(value):
	# Define a propriedade 'quantidade', acionando o setter e a atualização.
	self.quantidade = int(value)
