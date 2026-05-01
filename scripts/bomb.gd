extends Node3D

signal bom_no
signal bom_duoc_go

const THOI_GIAN_NO = 40.0
const THOI_GIAN_GO = 10.0
const BAN_KINH_NO = 6.0
const DUONG_DAN_BEEP = "res://assets/sounds/bom/beep.ogg"
const DUONG_DAN_NO = "res://assets/sounds/luu_dan/no_lon.ogg"

var thoi_gian_con_lai = THOI_GIAN_NO
var dang_duoc_go = false
var da_no = false
var tien_do_go = 0.0
var bo_dem_beep = 0.0

@onready var timer_no = $TimerNo
@onready var timer_go = $TimerGo
@onready var am_thanh_beep = $AmThanhBeep

func _ready():
	add_to_group("bom")
	timer_no.wait_time = THOI_GIAN_NO
	timer_no.timeout.connect(_no_bom)
	timer_no.start()
	if ResourceLoader.exists(DUONG_DAN_BEEP):
		am_thanh_beep.stream = load(DUONG_DAN_BEEP)
		am_thanh_beep.unit_size = 20.0

func _process(delta):
	if da_no:
		return

	thoi_gian_con_lai -= delta
	_cap_nhat_hud_bom()
	_xu_ly_beep(delta)

	if dang_duoc_go:
		tien_do_go += delta / THOI_GIAN_GO
		_cap_nhat_thanh_go()
		if tien_do_go >= 1.0:
			_go_bom_thanh_cong()

func _xu_ly_beep(delta: float):
	if am_thanh_beep.stream == null:
		return
	bo_dem_beep -= delta
	if bo_dem_beep > 0:
		return
	bo_dem_beep = _chu_ky_beep()
	am_thanh_beep.pitch_scale = 1.0 + (1.0 - thoi_gian_con_lai / THOI_GIAN_NO) * 0.4
	am_thanh_beep.play()

func _chu_ky_beep() -> float:
	if thoi_gian_con_lai > 30.0:
		return 1.0
	if thoi_gian_con_lai > 10.0:
		return 0.7
	if thoi_gian_con_lai > 5.0:
		return 0.4
	return 0.2

func bat_dau_go():
	dang_duoc_go = true
	tien_do_go = 0.0

func dung_go():
	dang_duoc_go = false

func _no_bom():
	if da_no:
		return
	da_no = true
	_gay_sat_thuong_vung_no()
	emit_signal("bom_no")
	_hien_hieu_ung_no()
	var round_mgr = get_tree().get_first_node_in_group("round_manager")
	if round_mgr:
		round_mgr.ket_thuc_hieu_p("B")
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _go_bom_thanh_cong():
	da_no = true
	timer_no.stop()
	emit_signal("bom_duoc_go")
	var hud_nguoi_choi = _lay_hud()
	if hud_nguoi_choi:
		hud_nguoi_choi.an_bom()
		hud_nguoi_choi.cap_nhat_tien_do_go(0.0)
	var round_mgr = get_tree().get_first_node_in_group("round_manager")
	if round_mgr:
		round_mgr.ket_thuc_hieu_p("A")
	queue_free()

func _lay_hud():
	var nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	if nguoi_choi:
		return nguoi_choi.get_node_or_null("HUD")
	return null

func _gay_sat_thuong_vung_no():
	var nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	if nguoi_choi:
		var khoang_cach = global_position.distance_to(nguoi_choi.global_position)
		if khoang_cach <= BAN_KINH_NO:
			var sat_thuong = int(500 * (1.0 - khoang_cach / BAN_KINH_NO))
			var hud = nguoi_choi.get_node_or_null("HUD")
			if hud:
				hud.nhan_sat_thuong(sat_thuong)

func _hien_hieu_ung_no():
	var anh_sang = OmniLight3D.new()
	anh_sang.light_color = Color(1, 0.5, 0.1, 1)
	anh_sang.light_energy = 8.0
	anh_sang.omni_range = 12.0
	get_tree().current_scene.add_child(anh_sang)
	anh_sang.global_position = global_position
	_phat_am_thanh_no()
	await get_tree().create_timer(0.5).timeout
	anh_sang.queue_free()

func _phat_am_thanh_no():
	if not ResourceLoader.exists(DUONG_DAN_NO):
		return
	var am_thanh = AudioStreamPlayer3D.new()
	am_thanh.stream = load(DUONG_DAN_NO)
	am_thanh.unit_size = 30.0
	am_thanh.max_db = 10.0
	get_tree().current_scene.add_child(am_thanh)
	am_thanh.global_position = global_position
	am_thanh.play()
	am_thanh.finished.connect(am_thanh.queue_free)

func _cap_nhat_hud_bom():
	var nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	if nguoi_choi:
		var hud = nguoi_choi.get_node_or_null("HUD")
		if hud and hud.has_method("cap_nhat_bom"):
			hud.cap_nhat_bom(thoi_gian_con_lai, THOI_GIAN_NO)

func _cap_nhat_thanh_go():
	var nguoi_choi = get_tree().get_first_node_in_group("nguoi_choi")
	if nguoi_choi:
		var hud = nguoi_choi.get_node_or_null("HUD")
		if hud and hud.has_method("cap_nhat_tien_do_go"):
			hud.cap_nhat_tien_do_go(tien_do_go)
