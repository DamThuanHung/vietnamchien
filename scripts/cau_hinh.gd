extends Node

# Singleton lưu cấu hình toàn cục: độ nhạy chuột, âm lượng, hiển thị FPS.
# Đăng ký autoload "CauHinh" trong project.godot.

const DUONG_DAN_FILE = "user://cau_hinh.cfg"

const DO_NHAY_MAC_DINH = 0.002
const AM_LUONG_MAC_DINH = 80
const HIEN_THI_FPS_MAC_DINH = false

var do_nhay_chuot: float = DO_NHAY_MAC_DINH
var am_luong: int = AM_LUONG_MAC_DINH
var hien_thi_fps: bool = HIEN_THI_FPS_MAC_DINH

signal cau_hinh_thay_doi

func _ready():
	doc()

func doc():
	var cfg = ConfigFile.new()
	var err = cfg.load(DUONG_DAN_FILE)
	if err != OK:
		# Chưa có file → giữ giá trị mặc định
		return
	do_nhay_chuot = cfg.get_value("dieu_khien", "do_nhay_chuot", DO_NHAY_MAC_DINH)
	am_luong = cfg.get_value("am_thanh", "am_luong", AM_LUONG_MAC_DINH)
	hien_thi_fps = cfg.get_value("hien_thi", "hien_thi_fps", HIEN_THI_FPS_MAC_DINH)

func luu():
	var cfg = ConfigFile.new()
	cfg.set_value("dieu_khien", "do_nhay_chuot", do_nhay_chuot)
	cfg.set_value("am_thanh", "am_luong", am_luong)
	cfg.set_value("hien_thi", "hien_thi_fps", hien_thi_fps)
	cfg.save(DUONG_DAN_FILE)
	emit_signal("cau_hinh_thay_doi")

func reset_mac_dinh():
	do_nhay_chuot = DO_NHAY_MAC_DINH
	am_luong = AM_LUONG_MAC_DINH
	hien_thi_fps = HIEN_THI_FPS_MAC_DINH
	luu()
