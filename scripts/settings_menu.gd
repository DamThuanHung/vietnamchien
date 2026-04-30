extends CanvasLayer

signal dong_cai_dat

@onready var thanh_nhay = $Khung/VBox/MucDoNhay/ThanhNhay
@onready var gia_tri_nhay = $Khung/VBox/MucDoNhay/HBoxNhay/GiaTriNhay
@onready var thanh_am = $Khung/VBox/MucAmLuong/ThanhAm
@onready var gia_tri_am = $Khung/VBox/MucAmLuong/HBoxAm/GiaTriAm
@onready var cong_tac_fps = $Khung/VBox/MucFps/CongTacFps
@onready var nut_mac_dinh = $Khung/VBox/HBoxNut/NutMacDinh
@onready var nut_dong = $Khung/VBox/HBoxNut/NutDong

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Đọc giá trị hiện tại
	thanh_nhay.value = CauHinh.do_nhay_chuot
	gia_tri_nhay.text = "%.4f" % CauHinh.do_nhay_chuot
	thanh_am.value = CauHinh.am_luong
	gia_tri_am.text = str(CauHinh.am_luong)
	cong_tac_fps.button_pressed = CauHinh.hien_thi_fps

	# Kết nối tín hiệu
	thanh_nhay.value_changed.connect(_on_nhay_thay_doi)
	thanh_am.value_changed.connect(_on_am_thay_doi)
	cong_tac_fps.toggled.connect(_on_fps_thay_doi)
	nut_mac_dinh.pressed.connect(_on_mac_dinh)
	nut_dong.pressed.connect(_on_dong)

func _on_nhay_thay_doi(gia_tri: float):
	CauHinh.do_nhay_chuot = gia_tri
	gia_tri_nhay.text = "%.4f" % gia_tri

func _on_am_thay_doi(gia_tri: float):
	CauHinh.am_luong = int(gia_tri)
	gia_tri_am.text = str(int(gia_tri))

func _on_fps_thay_doi(bat: bool):
	CauHinh.hien_thi_fps = bat

func _on_mac_dinh():
	CauHinh.reset_mac_dinh()
	thanh_nhay.value = CauHinh.do_nhay_chuot
	thanh_am.value = CauHinh.am_luong
	cong_tac_fps.button_pressed = CauHinh.hien_thi_fps
	gia_tri_nhay.text = "%.4f" % CauHinh.do_nhay_chuot
	gia_tri_am.text = str(CauHinh.am_luong)

func _on_dong():
	CauHinh.luu()
	emit_signal("dong_cai_dat")
	queue_free()
