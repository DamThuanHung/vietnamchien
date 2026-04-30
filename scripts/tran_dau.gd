extends Node

# Singleton lưu thông tin trận hiện tại: phe địch, tên đội, màu.
# Mỗi map gọi set_tran(phe_dich) ở _ready.
# Đăng ký autoload "TranDau" trong project.godot.

const PHE_HOP_LE = ["my", "phap"]

const THONG_TIN_PHE = {
	"my": {
		"ten_doi": "LÍNH MỸ",
		"ten_ca_nhan": "Lính Mỹ",
		"mau_doi": Color(0.25, 0.55, 1.0),
		"mau_than": Color(0.45, 0.42, 0.30),
		"mau_thanh_mau": Color(0.25, 0.55, 1.0),
	},
	"phap": {
		"ten_doi": "LÍNH PHÁP",
		"ten_ca_nhan": "Lính Pháp",
		"mau_doi": Color(0.3, 0.75, 0.35),
		"mau_than": Color(0.20, 0.25, 0.40),
		"mau_thanh_mau": Color(0.3, 0.75, 0.35),
	},
}

# Phe người chơi (đội A) — luôn cố định
const TEN_DOI_A = "BỘ ĐỘI CỤ HỒ"
const MAU_DOI_A = Color(0.95, 0.3, 0.3)

var phe_dich: String = "my"

func set_tran(phe: String):
	if phe in PHE_HOP_LE:
		phe_dich = phe
	else:
		push_warning("Phe không hợp lệ: %s — giữ mặc định 'my'" % phe)
		phe_dich = "my"

func thong_tin_dich() -> Dictionary:
	return THONG_TIN_PHE[phe_dich]
