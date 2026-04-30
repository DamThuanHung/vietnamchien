extends CanvasLayer

signal on_kill(loai_vu_khi)

const MAU_TOI_DA = 100
const THOI_GIAN_CHET = 3.0

var mau_hien_tai = MAU_TOI_DA
var so_kill = 0
var dang_chet = false
var do_no_crosshair = 0.0
var _thong_bao_nhanh_tg = 0.0

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

func _ready():
	man_hinh_chet.visible = false
	thong_bao_hieu_p.visible = false
	thong_bao_nhanh.visible = false
	khu_bom.visible = false
	khu_go_bom.visible = false
	nhan_hint.text = ""
	cap_nhat_hud()

func _process(delta):
	cap_nhat_crosshair(delta)
	if _thong_bao_nhanh_tg > 0:
		_thong_bao_nhanh_tg -= delta
		if _thong_bao_nhanh_tg <= 0:
			thong_bao_nhanh.visible = false

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
	chu_diem_a.text = str(diem_a)
	chu_diem_b.text = str(diem_b)
	chu_hieu_p.text = str(hieu_p)

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

func hien_bang_diem(hien: bool):
	pass

func chet():
	dang_chet = true
	man_hinh_chet.visible = true
	await get_tree().create_timer(THOI_GIAN_CHET).timeout
	hoi_sinh()

func hoi_sinh():
	mau_hien_tai = MAU_TOI_DA
	dang_chet = false
	man_hinh_chet.visible = false
	cap_nhat_hud()
	var player = get_parent()
	player.global_position = Vector3(0, 2, 0)
