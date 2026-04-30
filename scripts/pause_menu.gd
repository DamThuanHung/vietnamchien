extends CanvasLayer

signal tiep_tuc

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$VBox/NutTiepTuc.pressed.connect(func(): emit_signal("tiep_tuc"))
	$VBox/NutThoat.pressed.connect(func(): get_tree().quit())
