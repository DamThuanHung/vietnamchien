extends CharacterBody3D

const MAU_TOI_DA = 100
const TOC_DO = 3.0
const TAM_PHAT_HIEN = 18.0
const TAM_TAN_CONG = 7.0
const SAT_THUONG = 12
const THOI_GIAN_BAN = 1.2
const TAM_TUAN_TRA = 4.0

var mau_hien_tai = MAU_TOI_DA
var nguoi_choi = null
var co_the_ban = true
var dang_song = true
var vi_tri_xuat_phat: Vector3
var vi_tri_tuan_tra: Vector3
var dang_tuan_tra = false

var ten_hien_thi: String = "Địch"
var so_thu_tu: int = 0

enum TrangThai { DUNG_YEN, TUAN_TRA, TRUY_DUOI, TAN_CONG }
var trang_thai = TrangThai.TUAN_TRA

@onready var nav_agent = $NavigationAgent3D
@onready var thanh_mau_dich = $ThanhMauDich

func _ready():
	add_to_group("dich")
	_dat_ten_va_mau()
	nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	vi_tri_xuat_phat = global_position
	vi_tri_tuan_tra = _chon_diem_tuan_tra()
	await get_tree().create_timer(randf_range(0.5, 2.0)).timeout
	_cap_nhat_tuan_tra()

func _dat_ten_va_mau():
	var info = TranDau.thong_tin_dich()
	# Số thứ tự duy nhất trong nhóm "dich"
	so_thu_tu = get_tree().get_nodes_in_group("dich").size()
	ten_hien_thi = "%s %d" % [info["ten_ca_nhan"], so_thu_tu]

	# Đổi màu thân theo phe địch
	for ten_node in ["ThanNguoi", "TayTrai", "TayPhai", "ChanTrai", "ChanPhai"]:
		var node = get_node_or_null(ten_node)
		if node:
			var vat_lieu = StandardMaterial3D.new()
			vat_lieu.albedo_color = info["mau_than"]
			node.set_surface_override_material(0, vat_lieu)

	# Đổi màu thanh máu world-space theo phe địch
	if thanh_mau_dich:
		var style = StyleBoxFlat.new()
		style.bg_color = info["mau_thanh_mau"]
		style.corner_radius_top_left = 2
		style.corner_radius_top_right = 2
		style.corner_radius_bottom_right = 2
		style.corner_radius_bottom_left = 2
		thanh_mau_dich.add_theme_stylebox_override("fill", style)

func _physics_process(delta):
	if not dang_song:
		return

	if not is_on_floor():
		velocity.y -= 9.8 * delta

	_cap_nhat_thanh_mau_vi_tri()
	cap_nhat_ai()
	move_and_slide()

func cap_nhat_ai():
	if nguoi_choi == null:
		nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
		return

	var khoang_cach = global_position.distance_to(nguoi_choi.global_position)

	if khoang_cach <= TAM_TAN_CONG:
		trang_thai = TrangThai.TAN_CONG
	elif khoang_cach <= TAM_PHAT_HIEN:
		trang_thai = TrangThai.TRUY_DUOI
	else:
		trang_thai = TrangThai.TUAN_TRA

	match trang_thai:
		TrangThai.TUAN_TRA:
			_xu_ly_tuan_tra()
		TrangThai.TRUY_DUOI:
			di_chuyen_den(nguoi_choi.global_position)
		TrangThai.TAN_CONG:
			velocity.x = 0
			velocity.z = 0
			nhin_ve_phia(nguoi_choi.global_position)
			if co_the_ban:
				ban_nguoi_choi()

func _xu_ly_tuan_tra():
	var khoang_cach_dich = global_position.distance_to(vi_tri_tuan_tra)
	if khoang_cach_dich < 1.0:
		vi_tri_tuan_tra = _chon_diem_tuan_tra()
		velocity.x = 0
		velocity.z = 0
	else:
		di_chuyen_den(vi_tri_tuan_tra)

func _chon_diem_tuan_tra() -> Vector3:
	var goc = randf_range(0, TAU)
	var khoang_cach = randf_range(2.0, TAM_TUAN_TRA)
	return vi_tri_xuat_phat + Vector3(cos(goc) * khoang_cach, 0, sin(goc) * khoang_cach)

func _cap_nhat_tuan_tra():
	vi_tri_tuan_tra = _chon_diem_tuan_tra()

func di_chuyen_den(vi_tri_dich):
	nav_agent.target_position = vi_tri_dich
	var buoc_tiep = nav_agent.get_next_path_position()
	var huong = buoc_tiep - global_position
	huong.y = 0
	if huong.length() < 0.3:
		# Nav mesh không có path — di chuyển thẳng đến mục tiêu
		huong = vi_tri_dich - global_position
		huong.y = 0
	if huong.length() > 0.3:
		huong = huong.normalized()
		velocity.x = huong.x * TOC_DO
		velocity.z = huong.z * TOC_DO
		nhin_ve_phia(vi_tri_dich)
	else:
		velocity.x = 0
		velocity.z = 0

func nhin_ve_phia(vi_tri):
	var huong = vi_tri - global_position
	huong.y = 0
	if huong.length() > 0.1:
		look_at(global_position + huong, Vector3.UP)

func ban_nguoi_choi():
	co_the_ban = false
	if is_instance_valid(nguoi_choi):
		var hud = nguoi_choi.get_node_or_null("HUD")
		if hud and hud.has_method("nhan_sat_thuong"):
			hud.nhan_sat_thuong(SAT_THUONG)
	await get_tree().create_timer(THOI_GIAN_BAN).timeout
	co_the_ban = true

func nhan_sat_thuong(sat_thuong):
	mau_hien_tai -= sat_thuong
	_cap_nhat_thanh_mau()
	if mau_hien_tai <= 0:
		chet()

func _cap_nhat_thanh_mau():
	if not thanh_mau_dich:
		return
	thanh_mau_dich.value = float(mau_hien_tai) / MAU_TOI_DA * 100.0

func _cap_nhat_thanh_mau_vi_tri():
	if not thanh_mau_dich:
		return
	var cam = get_viewport().get_camera_3d()
	if not cam:
		return
	var pos_3d = global_position + Vector3(0, 2.3, 0)
	if not cam.is_position_in_frustum(pos_3d):
		thanh_mau_dich.visible = false
		return
	thanh_mau_dich.visible = true
	var vi_tri_2d = cam.unproject_position(pos_3d)
	thanh_mau_dich.position = vi_tri_2d - Vector2(thanh_mau_dich.size.x * 0.5, 0)

func chet():
	dang_song = false
	if thanh_mau_dich:
		thanh_mau_dich.visible = false
	queue_free()
