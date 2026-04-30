extends OmniLight3D

func _ready():
	light_energy = 0.0

func flash():
	light_energy = 3.0
	await get_tree().create_timer(0.05).timeout
	light_energy = 0.0
