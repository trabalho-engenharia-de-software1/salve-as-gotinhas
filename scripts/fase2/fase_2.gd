extends Node2D

var agua_maxima: float = 100.0
var agua_atual: float = 100.0

@onready var reservatorio = $Reservatorio
@onready var botao_ajuda = $HelpLayer/botaoAjuda

# --- MUDANÇA 1: Variáveis para guardar as coordenadas manuais ---
var reservatorio_pos_manual: Vector2
var reservatorio_raios_manual: Vector2


func _ready():
	reservatorio.atualizar_nivel(agua_atual, agua_maxima)
	
	var todas_as_opcoes = get_tree().get_nodes_in_group("opcoes_clicaveis")
	
	for opcao in todas_as_opcoes:
		opcao.toggled.connect(_on_opcao_toggled.bind(opcao))
		
	await get_tree().process_frame
	
	# --- 1. PEGUE AS REFERÊNCIAS ---
	
	# O alvo do reservatório (manual)
	var pos_manual_reserv = Vector2(70, 140) # Use os valores que funcionam
	var raios_manual_reserv = Vector2(80, 130)
	
	# Alvo 3: O BOTÃO do chuveiro (o primeiro 'OpcaoGasto' na lista do grupo)
	var alvo_botao_chuveiro = todas_as_opcoes[0]
	
	# Alvo 4: As GOTAS do chuveiro (o nó 'Gotas' DENTRO do 'alvo_botao_chuveiro')
	var alvo_gotas_do_chuveiro = alvo_botao_chuveiro.get_node("Gotas/gotinha3")
	# --- 2. CRIE A LISTA COMPLETA DE PASSOS ---
	var lista_de_passos = [
		{
			"tipo": "alvo_manual",
			"pos_centro_pixels": pos_manual_reserv,
			"raios_pixels": raios_manual_reserv,
			"texto": "Este é o seu reservatório. O objetivo é deixá-lo em 0!"
		},
		{
			"tipo": "alvo_automatico",
			"alvo": alvo_botao_chuveiro, # O alvo é o chuveiro
			"texto": "Clique aqui para usar o chuveiro."
		},
		{
			"tipo": "alvo_automatico",
			"alvo": alvo_gotas_do_chuveiro, # O alvo são as GOTAS do chuveiro
			"texto": "O chuveiro gasta 3 gotas (30 de água)."
		}
		# (Adicione mais passos para os outros itens)
	]
	
	botao_ajuda.habilitar_ajuda_com_passos(lista_de_passos)

# Função chamada quando QUALQUER OpcaoGasto é clicada
func _on_opcao_toggled(foi_marcado: bool, opcao_clicada):
	# ... (lógica de gasto de água) ...
	var custo = opcao_clicada.custo_e_gotas
	if foi_marcado:
		agua_atual -= 10 * custo
	else:
		agua_atual += 10 * custo
	agua_atual = clamp(agua_atual, -1.0, agua_maxima) 
	reservatorio.atualizar_nivel(agua_atual, agua_maxima)
	
	
	# --- MUDANÇA 3: Usando o Círculo MANUAL para Vitória/Derrota ---
	
	if is_zero_approx(agua_atual):
		# 1. MOSTRA o popup de vitória
		PopupManager.mostrar_ajuda_manual(
			Vector2(0, 0),  # Use os valores que você ajustou
			Vector2(0, 0), 
			"VOCÊ GASTOU COM SABEDORIA!"
		)
		
		# 2. ESPERA o jogador ler
		await get_tree().create_timer(3.0).timeout
		
		# 3. MANDA O POPUP SE ESCONDER
		PopupManager.esconder_ajuda()
		
		# 4. (Segurança) Espera 1 frame para o popup sumir
		await get_tree().process_frame
		
		# 5. VOLTA AO MENU
		get_tree().change_scene_to_file("res://cenas/menu-inicial/menu-inicial.tscn")
	
	elif agua_atual < 0:
		# 1. MOSTRA o popup de derrota
		PopupManager.mostrar_ajuda_manual(
			reservatorio_pos_manual, 
			reservatorio_raios_manual, 
			"A ÁGUA ACABOU!"
		)
		
		# 2. ESPERA o jogador ler
		await get_tree().create_timer(3.0).timeout
		
		# 3. MANDA O POPUP SE ESCONDER
		PopupManager.esconder_ajuda()
		
		# 4. (Segurança) Espera 1 frame para o popup sumir
		await get_tree().process_frame
		
		# 5. REINICIA A FASE
		get_tree().change_scene_to_file("res://cenas/fase2/fase2_cena.tscn")
