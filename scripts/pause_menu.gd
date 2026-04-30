extends CanvasLayer

signal tiep_tuc

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$VBox/NutTiepTuc.pressed.connect(func(): emit_signal("tiep_tuc"))
	$VBox/NutCaiDat.pressed.connect(_mo_cai_dat)
	$VBox/NutThoat.pressed.connect(func(): get_tree().quit())

func _mo_cai_dat():
	# Ẩn pause menu khi mở cài đặt để tránh chồng lên nhau
	$Nen.visible = false
	$VBox.visible = false
	var menu_scene = load("res://scenes/settings_menu.tscn")
	var menu = menu_scene.instantiate()
	menu.dong_cai_dat.connect(_dong_cai_dat)
	add_child(menu)

func _dong_cai_dat():
	$Nen.visible = true
	$VBox.visible = true
