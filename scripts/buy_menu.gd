extends CanvasLayer

signal mua_sung(ma_sung)

const WeaponData = preload("res://scripts/weapon_data.gd")

var tien_hien_tai = 800
var dang_mo = false

@onready var panel = $Panel
@onready var chu_tien = $Panel/VBox/TienHienTai
@onready var danh_sach_sung = $Panel/VBox/ScrollContainer/DanhSachSung
@onready var thong_bao = $Panel/VBox/ThongBao

const THU_TU_LOAI = [
	"can_chien",
	"sung_luc",
	"tieu_lien",
	"sung_truong",
	"sung_may",
	"ban_tia",
	"phong_luu",
	"luu_dan",
]

const TEN_LOAI = {
	"can_chien":  "── CẬN CHIẾN ──",
	"sung_luc":   "── SÚNG LỤC ──",
	"tieu_lien":  "── TIỂU LIÊN ──",
	"sung_truong":"── SÚNG TRƯỜNG ──",
	"sung_may":   "── SÚNG MÁY ──",
	"ban_tia":    "── BẮN TỈA ──",
	"phong_luu":  "── PHÓNG LỰU ──",
	"luu_dan":    "── LỰU ĐẠN ──",
}

func _ready():
	panel.visible = false
	_tao_danh_sach()

func _tao_danh_sach():
	var data_script = WeaponData.new()
	var tat_ca = data_script.SUNG

	for loai in THU_TU_LOAI:
		var co_sung = false
		for ma in tat_ca:
			if tat_ca[ma]["loai"] == loai:
				co_sung = true
				break
		if not co_sung:
			continue

		# Tiêu đề loại
		var tieu_de = Label.new()
		tieu_de.text = TEN_LOAI[loai]
		tieu_de.add_theme_color_override("font_color", Color(0.7, 0.7, 0.4, 1))
		tieu_de.add_theme_font_size_override("font_size", 13)
		danh_sach_sung.add_child(tieu_de)

		# Các súng trong loại
		for ma in tat_ca:
			var d = tat_ca[ma]
			if d["loai"] != loai:
				continue

			var btn = Button.new()
			var phe = ""
			match d.get("phe", "chung"):
				"viet_nam": phe = "[VN]"
				"my":       phe = "[MỸ]"
				"phap":     phe = "[PHÁP]"
				_:          phe = "[--]"

			var dan_info = ""
			if d["dan_trong_bang"] > 0:
				dan_info = "  |  Đạn: %d" % d["dan_trong_bang"]

			btn.text = "%s %s  —  %d$  |  ST: %d%s" % [
				phe,
				d["ten"],
				d["gia"],
				d["sat_thuong"],
				dan_info
			]
			btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
			btn.add_theme_font_size_override("font_size", 14)

			# Màu theo giá
			if d["gia"] == 0:
				btn.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
			elif d["gia"] < 1500:
				btn.add_theme_color_override("font_color", Color(0.6, 1.0, 0.6))
			elif d["gia"] < 3000:
				btn.add_theme_color_override("font_color", Color(0.6, 0.8, 1.0))
			else:
				btn.add_theme_color_override("font_color", Color(1.0, 0.7, 0.3))

			btn.pressed.connect(_on_mua_sung.bind(ma))
			danh_sach_sung.add_child(btn)

	data_script.free()

func _input(event):
	if get_tree().paused:
		return
	if event.is_action_pressed("mo_buy_menu"):
		if dang_mo:
			dong()
		else:
			mo()

func mo():
	dang_mo = true
	panel.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	cap_nhat_tien()

func dong():
	dang_mo = false
	panel.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func cap_nhat_tien():
	chu_tien.text = "Tiền: %d$" % tien_hien_tai

func them_tien(so_tien: int):
	tien_hien_tai += so_tien
	if panel.visible:
		cap_nhat_tien()

func _on_mua_sung(ma_sung: String):
	var data_script = WeaponData.new()
	var d = data_script.SUNG[ma_sung]
	data_script.free()

	if tien_hien_tai >= d["gia"]:
		tien_hien_tai -= d["gia"]
		cap_nhat_tien()
		emit_signal("mua_sung", ma_sung)
		dong()
	else:
		thong_bao.text = "Không đủ tiền!"
		thong_bao.add_theme_color_override("font_color", Color(1, 0.2, 0.2))
		await get_tree().create_timer(1.5).timeout
		thong_bao.text = ""
