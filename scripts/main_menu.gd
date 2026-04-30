extends CanvasLayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBox/NutChoi.pressed.connect(_on_choi_pressed)
	$VBox/NutThoat.pressed.connect(_on_thoat_pressed)

func _on_choi_pressed():
	get_tree().change_scene_to_file("res://maps/map_test.tscn")

func _on_thoat_pressed():
	get_tree().quit()
