extends CharacterBody3D

const TOC_DO_CHAY = 5.0
const TOC_DO_DI_BO = 2.2
const TOC_DO_NGOI = 1.4
const LUC_NHAY = 4.5
const DO_NHAY_CAM_CHUOT = 0.002
const TRONG_LUC = -9.8
const CAO_DUNG = 1.6
const CAO_NGOI = 0.9
const TAM_GO_BOM = 2.5

var camera: Camera3D
var dang_ngoi = false
var dang_co_bom = true
var dang_tam_dung = false
var dang_cam_luu_dan = false
var bom_gan: Node3D = null
var so_luu_dan = 2

@onready var collision = $CollisionShape3D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	camera = $Camera3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("nguoi_choi")
	_ket_noi_he_thong()

func _ket_noi_he_thong():
	var buy_menu = $BuyMenu
	var gun = $Camera3D/Gun
	var economy = $Economy
	var weapon_data = load("res://scripts/weapon_data.gd").new()

	economy.tien_thay_doi.connect(func(so_tien):
		buy_menu.tien_hien_tai = so_tien
		buy_menu.cap_nhat_tien()
		$HUD.cap_nhat_tien(so_tien)
	)
	buy_menu.tien_hien_tai = economy.tien
	$HUD.cap_nhat_tien(economy.tien)

	buy_menu.mua_sung.connect(func(ma_sung):
		var data = weapon_data.SUNG[ma_sung]
		economy.tru_tien(data["gia"])
		buy_menu.tien_hien_tai = economy.tien
		gun.trang_bi_sung(data)
	)

	$HUD.on_kill.connect(func(loai_vu_khi):
		var thuong = economy.them_tien("kill_" + loai_vu_khi)
		$HUD.hien_thuong_tien(thuong)
	)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_toggle_tam_dung()
		return

	# [DEBUG ONLY] F1 = +5000$ để test buy menu
	if OS.is_debug_build() and event is InputEventKey and event.pressed and event.keycode == KEY_F1:
		$Economy.them_tien_truc_tiep(5000)
		$HUD.hien_thong_bao_nhanh("[TEST] +5000$")
		return

	# [DEBUG ONLY] F2 = thắng trận luôn để test bảng kết quả
	if OS.is_debug_build() and event is InputEventKey and event.pressed and event.keycode == KEY_F2:
		var rm = get_tree().get_first_node_in_group("round_manager")
		if rm:
			rm.diem_doi_a = rm.SO_THANG_DE_WIN - 1
			rm.ket_thuc_hieu_p("A")
		return

	# [DEBUG ONLY] F3 = thua trận luôn để test bảng kết quả
	if OS.is_debug_build() and event is InputEventKey and event.pressed and event.keycode == KEY_F3:
		var rm = get_tree().get_first_node_in_group("round_manager")
		if rm:
			rm.diem_doi_b = rm.SO_THANG_DE_WIN - 1
			rm.ket_thuc_hieu_p("B")
		return

	if get_tree().paused:
		return

	if has_node("BuyMenu") and $BuyMenu.dang_mo:
		return

	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * DO_NHAY_CAM_CHUOT)
		camera.rotate_x(-event.relative.y * DO_NHAY_CAM_CHUOT)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2.2, PI/2.2)

	if event.is_action_pressed("ngoi"):
		_bat_ngoi()
	if event.is_action_released("ngoi"):
		_dung_len()

	if event.is_action_pressed("dat_bom"):
		if dang_co_bom:
			_dat_bom()
		elif bom_gan != null and is_instance_valid(bom_gan) and not bom_gan.da_no:
			bom_gan.bat_dau_go()
	if event.is_action_released("dat_bom"):
		if bom_gan != null and is_instance_valid(bom_gan):
			bom_gan.dung_go()

	if event.is_action_pressed("nem_luu_dan"):
		_toggle_cam_luu_dan()

	if event.is_action_pressed("ban") and dang_cam_luu_dan:
		_nem_luu_dan()

	if event.is_action_pressed("mo_bang_diem"):
		$HUD.hien_bang_diem(true)
	if event.is_action_released("mo_bang_diem"):
		$HUD.hien_bang_diem(false)

func _toggle_tam_dung():
	dang_tam_dung = not dang_tam_dung
	if dang_tam_dung:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		var menu = load("res://scenes/pause_menu.tscn").instantiate()
		get_tree().current_scene.add_child(menu)
		menu.tiep_tuc.connect(_tiep_tuc)
	else:
		_tiep_tuc()

func _tiep_tuc():
	dang_tam_dung = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var menu = get_tree().current_scene.get_node_or_null("PauseMenu")
	if menu:
		menu.queue_free()

func _physics_process(delta):
	if get_tree().paused:
		return

	_kiem_tra_bom_gan()

	if not is_on_floor():
		velocity.y += TRONG_LUC * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and not dang_ngoi:
		velocity.y = LUC_NHAY

	var huong = Vector3.ZERO
	# Shift = đi nhẹ (CS:GO style), mặc định = chạy
	var toc_do = TOC_DO_NGOI if dang_ngoi else (TOC_DO_DI_BO if Input.is_action_pressed("chay") else TOC_DO_CHAY)

	if Input.is_action_pressed("di_truoc"):
		huong -= transform.basis.z
	if Input.is_action_pressed("di_lui"):
		huong += transform.basis.z
	if Input.is_action_pressed("di_trai"):
		huong -= transform.basis.x
	if Input.is_action_pressed("di_phai"):
		huong += transform.basis.x

	huong = huong.normalized()
	velocity.x = huong.x * toc_do
	velocity.z = huong.z * toc_do

	move_and_slide()

func _kiem_tra_bom_gan():
	bom_gan = null
	var cac_bom = get_tree().get_nodes_in_group("bom")
	for bom in cac_bom:
		if is_instance_valid(bom) and global_position.distance_to(bom.global_position) <= TAM_GO_BOM:
			bom_gan = bom
			break

	if bom_gan != null and not dang_co_bom:
		$HUD.set_hint("[F] Gỡ bom")
	else:
		$HUD.set_hint("")

func _bat_ngoi():
	dang_ngoi = true
	collision.scale.y = 0.5
	camera.position.y = CAO_NGOI

func _dung_len():
	dang_ngoi = false
	collision.scale.y = 1.0
	camera.position.y = CAO_DUNG

func _dat_bom():
	var bom_scene = load("res://scenes/bomb.tscn")
	var bom = bom_scene.instantiate()
	get_tree().current_scene.add_child(bom)
	bom.global_position = global_position + Vector3(0, -0.5, 0)
	dang_co_bom = false
	$HUD.hien_thong_bao_nhanh("Đã đặt bom! [F = Gỡ]")

func _toggle_cam_luu_dan():
	if so_luu_dan <= 0:
		$HUD.hien_thong_bao_nhanh("Hết lựu đạn!")
		return
	dang_cam_luu_dan = not dang_cam_luu_dan
	if dang_cam_luu_dan:
		$HUD.hien_thong_bao_nhanh("Lựu đạn [Chuột trái = Ném]")
	else:
		$HUD.hien_thong_bao_nhanh("")

func _nem_luu_dan():
	dang_cam_luu_dan = false
	so_luu_dan -= 1
	var luu_dan_scene = load("res://scenes/grenade.tscn")
	var luu_dan = luu_dan_scene.instantiate()
	get_tree().current_scene.add_child(luu_dan)
	luu_dan.global_position = camera.global_position
	var huong = -camera.global_transform.basis.z
	luu_dan.nem(huong)
	$HUD.hien_thong_bao_nhanh("Lựu đạn (%d còn lại)" % so_luu_dan)
