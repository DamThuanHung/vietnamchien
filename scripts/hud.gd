extends CanvasLayer

signal on_kill(loai_vu_khi)

const MAU_TOI_DA = 100
const THOI_GIAN_CHET = 3.0

var mau_hien_tai = MAU_TOI_DA
var so_kill = 0
var so_chet = 0
var dang_chet = false
var do_no_crosshair = 0.0
var _thong_bao_nhanh_tg = 0.0

# Dữ liệu cho bảng điểm
var diem_a_hien = 0
var diem_b_hien = 0
var hieu_p_hien = 1
var tong_dich_lon_nhat = 0

@onready var thanh_mau = $KhungMau/VBoxContainer/ThanhMau
@onready var chu_so_mau = $KhungMau/VBoxContainer/ChuSoMau
@onready var crosshair_v = $CrosshairV
@onready var crosshair_h = $CrosshairH
@onready var crosshair_dot = $CrosshairDot
@onready var man_hinh_chet = $ManHinhChet
@onready var nhan_kill = $KillFeed
@onready var chu_kill = $KhuKill/VBox/SoKill
@onready var chu_thoi_gian = $KhuTrung/ThoiGian
@onready var chu_diem_a = $KhuTrung/DiemDoiA
@onready var chu_diem_b = $KhuTrung/DiemDoiB
@onready var chu_hieu_p = $KhuTrung/SoHieuP
@onready var thong_bao_hieu_p = $ThongBaoHieuP
@onready var chu_dan = $KhuDan/Dan
@onready var chu_ten_sung = $KhuDan/TenSung
@onready var nhan_hint = $NhanHint
@onready var thong_bao_nhanh = $ThongBaoNhanh
@onready var khu_bom = $KhuBom
@onready var thoi_gian_bom_label = $KhuBom/VBoxBom/ThoiGianBom
@onready var thanh_bom = $KhuBom/VBoxBom/ThanhBom
@onready var khu_go_bom = $KhuGoBom
@onready var thanh_go = $KhuGoBom/ThanhGo
@onready var label_tien = $LabelTien
@onready var nhan_fps = $NhanFps
@onready var bang_diem = $BangDiem
@onready var ty_tan_label = $BangDiem/VBox/TyTan
@onready var danh_sach_a = $BangDiem/VBox/HBoxCot/ColDoiA/DanhSachA
@onready var danh_sach_b = $BangDiem/VBox/HBoxCot/ColDoiB/DanhSachB
@onready var duong_ke_ket_qua = $BangDiem/VBox/DuongKeKetQua
@onready var tieu_de_ket_qua = $BangDiem/VBox/TieuDeKetQua
@onready var dong_dem_nguoc = $BangDiem/VBox/DongDemNguoc
@onready var nut_ve_menu = $BangDiem/VBox/NutVeMenu

const THOI_GIAN_CHO_VE_MENU = 15
var dang_o_ket_qua = false
var thoi_gian_dem_nguoc = 0

func _ready():
	man_hinh_chet.visible = false
	thong_bao_hieu_p.visible = false
	thong_bao_nhanh.visible = false
	khu_bom.visible = false
	khu_go_bom.visible = false
	bang_diem.visible = false
	nut_ve_menu.pressed.connect(_ve_menu_chinh)
	nhan_hint.text = ""
	nhan_fps.visible = CauHinh.hien_thi_fps
	CauHinh.cau_hinh_thay_doi.connect(_cap_nhat_hien_thi_fps)
	cap_nhat_hud()

func _cap_nhat_hien_thi_fps():
	nhan_fps.visible = CauHinh.hien_thi_fps

func _process(delta):
	cap_nhat_crosshair(delta)
	if _thong_bao_nhanh_tg > 0:
		_thong_bao_nhanh_tg -= delta
		if _thong_bao_nhanh_tg <= 0:
			thong_bao_nhanh.visible = false
	if nhan_fps.visible:
		nhan_fps.text = "FPS: %d" % int(Engine.get_frames_per_second())

func cap_nhat_crosshair(delta):
	do_no_crosshair = lerp(do_no_crosshair, 0.0, delta * 8.0)
	var do_rong = 8.0 + do_no_crosshair * 15.0
	crosshair_v.offset_top = -do_rong
	crosshair_v.offset_bottom = do_rong
	crosshair_h.offset_left = -do_rong
	crosshair_h.offset_right = do_rong

func no_crosshair():
	do_no_crosshair = 1.0

func nhan_sat_thuong(sat_thuong):
	if dang_chet:
		return
	mau_hien_tai = max(0, mau_hien_tai - sat_thuong)
	cap_nhat_hud()
	if mau_hien_tai <= 0:
		chet()

func hoi_mau(luong):
	mau_hien_tai = min(MAU_TOI_DA, mau_hien_tai + luong)
	cap_nhat_hud()

func them_kill(ten_dich, loai_vu_khi: String = "sung"):
	so_kill += 1
	chu_kill.text = str(so_kill)
	them_kill_feed("Bạn đã hạ " + ten_dich)
	emit_signal("on_kill", loai_vu_khi)
	if bang_diem.visible:
		_ve_bang_diem()

func hien_thuong_tien(so_tien: int):
	var nhan = Label.new()
	nhan.text = "+%d$" % so_tien
	nhan.add_theme_color_override("font_color", Color(0.3, 1.0, 0.3, 1))
	nhan.add_theme_font_size_override("font_size", 18)
	nhan.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	nhan.anchors_preset = 8
	nhan.anchor_left = 0.5
	nhan.anchor_top = 0.5
	nhan.anchor_right = 0.5
	nhan.anchor_bottom = 0.5
	nhan.offset_left = -50
	nhan.offset_top = -120
	nhan.offset_right = 50
	nhan.offset_bottom = -90
	add_child(nhan)
	await get_tree().create_timer(1.5).timeout
	nhan.queue_free()

func them_kill_feed(thong_bao):
	var nhan = Label.new()
	nhan.text = thong_bao
	nhan.add_theme_color_override("font_color", Color(1, 0.8, 0.2, 1))
	nhan.add_theme_font_size_override("font_size", 14)
	nhan_kill.add_child(nhan)
	await get_tree().create_timer(3.0).timeout
	nhan.queue_free()

func cap_nhat_hud():
	thanh_mau.value = mau_hien_tai
	chu_so_mau.text = str(mau_hien_tai)

func cap_nhat_thoi_gian(giay):
	var phut = giay / 60
	var giay_con = giay % 60
	chu_thoi_gian.text = "%d:%02d" % [phut, giay_con]

func cap_nhat_diem(diem_a: int, diem_b: int, hieu_p: int):
	diem_a_hien = diem_a
	diem_b_hien = diem_b
	hieu_p_hien = hieu_p
	chu_diem_a.text = str(diem_a)
	chu_diem_b.text = str(diem_b)
	chu_hieu_p.text = str(hieu_p)
	if bang_diem.visible:
		_ve_bang_diem()

func hien_thong_bao(noi_dung: String, mau: Color):
	thong_bao_hieu_p.text = noi_dung
	thong_bao_hieu_p.add_theme_color_override("font_color", mau)
	thong_bao_hieu_p.visible = true
	await get_tree().create_timer(3.0).timeout
	thong_bao_hieu_p.visible = false

func hien_thong_bao_nhanh(text: String):
	thong_bao_nhanh.text = text
	thong_bao_nhanh.visible = true
	_thong_bao_nhanh_tg = 2.5

func set_hint(text: String):
	nhan_hint.text = text
	nhan_hint.visible = text.length() > 0

func cap_nhat_dan(hien_tai: int, toi_da: int, ten: String, dang_nap: bool = false):
	chu_ten_sung.text = ten
	if dang_nap:
		chu_dan.text = "NẠP ĐẠN..."
		chu_dan.add_theme_color_override("font_color", Color(1, 0.8, 0.2))
	else:
		chu_dan.text = "%d / %d" % [hien_tai, toi_da]
		if hien_tai == 0:
			chu_dan.add_theme_color_override("font_color", Color(1, 0.2, 0.2))
		elif hien_tai <= 5:
			chu_dan.add_theme_color_override("font_color", Color(1, 0.5, 0.2))
		else:
			chu_dan.add_theme_color_override("font_color", Color(1, 1, 1))

func hien_thong_bao_nap(thoi_gian: float):
	hien_thong_bao_nhanh("Nạp đạn (%.1fs)" % thoi_gian)

func cap_nhat_bom(thoi_gian_con_lai: float, toi_da: float):
	khu_bom.visible = true
	thoi_gian_bom_label.text = "%d" % int(ceil(thoi_gian_con_lai))
	thanh_bom.value = (thoi_gian_con_lai / toi_da) * 100.0
	if thoi_gian_con_lai <= 10:
		thoi_gian_bom_label.add_theme_color_override("font_color", Color(1, 0.1, 0.1))
	elif thoi_gian_con_lai <= 20:
		thoi_gian_bom_label.add_theme_color_override("font_color", Color(1, 0.5, 0.1))
	else:
		thoi_gian_bom_label.add_theme_color_override("font_color", Color(1, 0.9, 0.1))

func an_bom():
	khu_bom.visible = false

func cap_nhat_tien_do_go(tien_do: float):
	khu_go_bom.visible = tien_do > 0.01
	thanh_go.value = tien_do * 100.0

func cap_nhat_tien(so_tien: int):
	label_tien.text = "$%d" % so_tien
	if bang_diem.visible:
		_ve_bang_diem()

func hien_bang_diem(hien: bool):
	# Khi đang ở chế độ kết quả cuối trận, không cho ẩn bảng bằng Tab
	if dang_o_ket_qua:
		return
	bang_diem.visible = hien
	if hien:
		_ve_bang_diem()

func hien_bang_ket_qua(doi_thang: String):
	dang_o_ket_qua = true
	bang_diem.visible = true
	_ve_bang_diem()

	duong_ke_ket_qua.visible = true
	tieu_de_ket_qua.visible = true
	dong_dem_nguoc.visible = true
	nut_ve_menu.visible = true

	if doi_thang == "A":
		tieu_de_ket_qua.text = "🎉  ĐỘI A — VIỆT NAM CHIẾN THẮNG  🎉"
		tieu_de_ket_qua.add_theme_color_override("font_color", Color(0.3, 1.0, 0.4, 1))
	else:
		tieu_de_ket_qua.text = "ĐỘI B THẮNG"
		tieu_de_ket_qua.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3, 1))

	# Thả chuột để bấm nút
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Đếm ngược tự động về menu
	thoi_gian_dem_nguoc = THOI_GIAN_CHO_VE_MENU
	_chay_dem_nguoc()

func _chay_dem_nguoc():
	while thoi_gian_dem_nguoc > 0 and dang_o_ket_qua:
		dong_dem_nguoc.text = "Tự về menu chính sau %d giây" % thoi_gian_dem_nguoc
		await get_tree().create_timer(1.0).timeout
		thoi_gian_dem_nguoc -= 1
	if dang_o_ket_qua:
		_ve_menu_chinh()

func _ve_menu_chinh():
	dang_o_ket_qua = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _ve_bang_diem():
	# Cập nhật dòng tỷ số
	ty_tan_label.text = "ĐỘI A  %d  :  %d  ĐỘI B    |    Hiệp %d / 15" % [
		diem_a_hien, diem_b_hien, hieu_p_hien
	]

	# Xóa các hàng cũ
	for con in danh_sach_a.get_children():
		con.queue_free()
	for con in danh_sach_b.get_children():
		con.queue_free()

	# Đội A: người chơi
	var tien_player = 0
	var player = get_parent()
	if player and player.has_node("Economy"):
		tien_player = player.get_node("Economy").tien
	danh_sach_a.add_child(_tao_hang_doi_a("Bạn", so_kill, so_chet, tien_player))

	# Đội B: tổng quân địch (vì là bot, gộp thành 1 hàng)
	var dich_con_song = get_tree().get_nodes_in_group("dich").size()
	var dich_da_chet = so_kill  # số địch player đã hạ
	var tong_dich = dich_con_song + dich_da_chet
	if tong_dich > tong_dich_lon_nhat:
		tong_dich_lon_nhat = tong_dich
	danh_sach_b.add_child(_tao_hang_doi_b(dich_con_song, tong_dich_lon_nhat))

func _tao_hang_doi_a(ten: String, so_ha: int, so_lan_chet: int, tien: int) -> HBoxContainer:
	var hang = HBoxContainer.new()

	var n_ten = Label.new()
	n_ten.text = ten
	n_ten.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	n_ten.add_theme_font_size_override("font_size", 16)
	n_ten.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	hang.add_child(n_ten)

	var n_k = Label.new()
	n_k.text = str(so_ha)
	n_k.custom_minimum_size = Vector2(40, 0)
	n_k.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	n_k.add_theme_font_size_override("font_size", 16)
	n_k.add_theme_color_override("font_color", Color(0.4, 1.0, 0.4, 1))
	hang.add_child(n_k)

	var n_d = Label.new()
	n_d.text = str(so_lan_chet)
	n_d.custom_minimum_size = Vector2(40, 0)
	n_d.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	n_d.add_theme_font_size_override("font_size", 16)
	n_d.add_theme_color_override("font_color", Color(1, 0.5, 0.5, 1))
	hang.add_child(n_d)

	var n_tien = Label.new()
	n_tien.text = "$%d" % tien
	n_tien.custom_minimum_size = Vector2(70, 0)
	n_tien.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	n_tien.add_theme_font_size_override("font_size", 16)
	n_tien.add_theme_color_override("font_color", Color(0.4, 1.0, 0.5, 1))
	hang.add_child(n_tien)

	return hang

func _tao_hang_doi_b(con_song: int, tong: int) -> VBoxContainer:
	var hop = VBoxContainer.new()

	var n_dong_chinh = Label.new()
	n_dong_chinh.text = "Quân địch (bot)"
	n_dong_chinh.add_theme_font_size_override("font_size", 16)
	n_dong_chinh.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	hop.add_child(n_dong_chinh)

	var n_thong_ke = Label.new()
	n_thong_ke.text = "Còn sống: %d / %d  •  Đã hạ: %d" % [con_song, tong, tong - con_song]
	n_thong_ke.add_theme_font_size_override("font_size", 14)
	n_thong_ke.add_theme_color_override("font_color", Color(0.85, 0.85, 0.85, 1))
	hop.add_child(n_thong_ke)

	return hop

func chet():
	dang_chet = true
	so_chet += 1
	man_hinh_chet.visible = true
	if bang_diem.visible:
		_ve_bang_diem()
	await get_tree().create_timer(THOI_GIAN_CHET).timeout
	hoi_sinh()

func hoi_sinh():
	mau_hien_tai = MAU_TOI_DA
	dang_chet = false
	man_hinh_chet.visible = false
	cap_nhat_hud()
	var player = get_parent()
	player.global_position = Vector3(0, 2, 0)
