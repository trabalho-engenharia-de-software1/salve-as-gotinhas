# Anexado ao seu nó "botaoAjuda" (o Button)
extends Button

# --- "Memória" do Botão ---
var no_alvo: Node = null # O NÓ QUE VAMOS DESTACAR
var texto_de_ajuda: String = "Ajuda não definida."

func _ready():
	self.pressed.connect(_on_pressed)

func _on_pressed():
	if not is_instance_valid(no_alvo):
		print("ERRO: Botão de ajuda clicado, mas 'no_alvo' não foi configurado pela cena pai.")
		return
		
	# CHAMA A FUNÇÃO DE AJUDA, NÃO A FUNÇÃO SIMPLES
	PopupManager.mostrar_ajuda_contextual(no_alvo, texto_de_ajuda)
