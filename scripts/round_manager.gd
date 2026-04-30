extends Node

signal hieu_p_moi
signal on_ket_thuc_hieu_p(thang)
signal cap_nhat_thoi_gian(thoi_gian)

const THOI_GIAN_HIEU_P = 115
const THOI_GIAN_NGHI = 5
const SO_THANG_DE_WIN = 8

var hieu_p_hien_tai = 1
var thoi_gian_con_lai = THOI_GIAN_HIEU_P
var diem_doi_a = 0
var diem_doi_b = 0
var dang_chay = false
var dang_nghi = false

@onready var timer = $Timer

func _ready():
	add_to_group("round_manager")
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timer_tick)
	bat_dau_hieu_p()

func bat_dau_hieu_p():
	thoi_gian_con_lai = THOI_GIAN_HIEU_P
	dang_chay = true
	dang_nghi = false
	timer.start()
	emit_signal("hieu_p_moi")
	_an_bom_hud()
	_dat_lai_nguoi_choi()

func _dat_lai_nguoi_choi():
	var nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	if nguoi_choi == null:
		return
	nguoi_choi.global_position = Vector3(0, 2, 0)
	nguoi_choi.dang_co_bom = true
	var hud = nguoi_choi.get_node_or_null("HUD")
	if hud:
		hud.mau_hien_tai = hud.MAU_TOI_DA
		hud.dang_chet = false
		hud.man_hinh_chet.visible = false
		hud.cap_nhat_hud()

func _on_timer_tick():
	if dang_nghi:
		return
	thoi_gian_con_lai -= 1
	emit_signal("cap_nhat_thoi_gian", thoi_gian_con_lai)
	if thoi_gian_con_lai <= 0:
		ket_thuc_hieu_p("B")

func ket_thuc_hieu_p(doi_thang: String):
	if not dang_chay:
		return
	dang_chay = false
	timer.stop()
	if doi_thang == "A":
		diem_doi_a += 1
	else:
		diem_doi_b += 1
	emit_signal("on_ket_thuc_hieu_p", doi_thang)
	_nghi_giua_hieu_p()

func _nghi_giua_hieu_p():
	dang_nghi = true
	await get_tree().create_timer(THOI_GIAN_NGHI).timeout
	hieu_p_hien_tai += 1
	if diem_doi_a >= SO_THANG_DE_WIN or diem_doi_b >= SO_THANG_DE_WIN:
		_ket_thuc_game()
		return
	bat_dau_hieu_p()

func _ket_thuc_game():
	var doi_thang = "A" if diem_doi_a >= SO_THANG_DE_WIN else "B"
	var nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	if nguoi_choi:
		var hud = nguoi_choi.get_node_or_null("HUD")
		if hud:
			var thong_bao = "BẠN ĐÃ THẮNG! 🎉" if doi_thang == "A" else "BẠN ĐÃ THUA!"
			var mau = Color(0.2, 1.0, 0.3) if doi_thang == "A" else Color(1.0, 0.2, 0.2)
			hud.hien_thong_bao(thong_bao, mau)
	await get_tree().create_timer(6.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _an_bom_hud():
	var nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	if nguoi_choi:
		var hud = nguoi_choi.get_node_or_null("HUD")
		if hud and hud.has_method("an_bom"):
			hud.an_bom()

func dinh_dang_thoi_gian(giay):
	var phut = giay / 60
	var giay_con = giay % 60
	return "%d:%02d" % [phut, giay_con]
