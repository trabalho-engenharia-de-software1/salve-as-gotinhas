extends Area2D

@onready var audio_player = $"../AudioStreamPlayer2D"
var timer := Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	print("Mouse entrou na área:", self.name)
	timer.start()

func _on_mouse_exited():
	print("Mouse saiu da área:", self.name)
	timer.stop()

func _on_timer_timeout():
	# Para o áudio caso já esteja tocando
	if audio_player.playing:
		audio_player.stop()

	# Toca o novo som
	audio_player.play()
