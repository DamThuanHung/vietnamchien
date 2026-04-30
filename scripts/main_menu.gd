extends CanvasLayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBox/NutChoi.pressed.connect(_on_choi_pressed)
	$VBox/NutCaiDat.pressed.connect(_on_cai_dat_pressed)
	$VBox/NutThoat.pressed.connect(_on_thoat_pressed)

func _on_choi_pressed():
	get_tree().change_scene_to_file("res://maps/map_test.tscn")

func _on_cai_dat_pressed():
	var menu_scene = load("res://scenes/settings_menu.tscn")
	var menu = menu_scene.instantiate()
	add_child(menu)

func _on_thoat_pressed():
	get_tree().quit()
