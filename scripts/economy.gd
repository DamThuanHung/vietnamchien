extends Node

# ============================================================
# BẢNG THƯỞNG TIỀN — CHẾ ĐỘ ĐẶT BOM (như CS:GO)
# ============================================================

const THUONG = {
	# Kill
	"kill_sung":        300,
	"kill_dao":         800,
	"kill_luu_dan":     300,
	"kill_sung_may":    300,

	# Kết quả hiệp — đội tấn công
	"tan_cong_thang":   3250,
	"tan_cong_thua":    1400,

	# Kết quả hiệp — đội phòng thủ
	"phong_thu_thang":  3250,
	"phong_thu_thua":   1400,

	# Bom
	"dat_bom":          300,
	"go_bom":           300,
	"bom_no":           0,

	# Thua liên tiếp (bonus vớt)
	"thua_1":           1400,
	"thua_2":           1900,
	"thua_3":           2400,
	"thua_4":           2900,
	"thua_5":           3400,
}

const TIEN_BAN_DAU = 800
const TIEN_TOI_DA = 16000

var tien = TIEN_BAN_DAU
var so_lan_thua_lien_tiep = 0

signal tien_thay_doi(so_tien)

func _ready():
	tien = TIEN_BAN_DAU

func them_tien(loai: String):
	var so_tien = THUONG.get(loai, 0)
	tien = min(tien + so_tien, TIEN_TOI_DA)
	emit_signal("tien_thay_doi", tien)
	return so_tien

func tru_tien(so_tien: int):
	tien = max(0, tien - so_tien)
	emit_signal("tien_thay_doi", tien)

func ket_thuc_hieu_p(thang: bool, la_tan_cong: bool):
	if thang:
		so_lan_thua_lien_tiep = 0
		var loai = "tan_cong_thang" if la_tan_cong else "phong_thu_thang"
		them_tien(loai)
	else:
		so_lan_thua_lien_tiep += 1
		var loai = "tan_cong_thua" if la_tan_cong else "phong_thu_thua"
		var tien_co_ban = THUONG[loai]
		var tien_bonus = _tinh_bonus_thua()
		tien = min(tien + tien_co_ban + tien_bonus, TIEN_TOI_DA)
		emit_signal("tien_thay_doi", tien)

func _tinh_bonus_thua() -> int:
	var lan = min(so_lan_thua_lien_tiep, 5)
	return THUONG.get("thua_%d" % lan, 0)

func reset_cho_hieu_p_moi():
	emit_signal("tien_thay_doi", tien)

func them_tien_truc_tiep(so_tien: int):
	tien = min(tien + so_tien, TIEN_TOI_DA)
	emit_signal("tien_thay_doi", tien)
