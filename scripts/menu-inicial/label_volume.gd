extends HSlider

@export var bus_name: String = "Master" 

var bus_index: int = -1

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	self.value_changed.connect(_on_value_changed)
	if bus_index != -1:
		self.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index)) * 100

func _on_value_changed(value: float) -> void:
	if bus_index == -1:
		return
		
	var linear_value = value / 100.0
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(linear_value))
