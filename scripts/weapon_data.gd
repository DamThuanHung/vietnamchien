extends Node

# ============================================================
# BẢNG DỮ LIỆU VŨ KHÍ — VIỆT NAM CHIẾN
# Để thêm vũ khí mới: copy 1 block, đổi key và điền thông số
# ============================================================

const SUNG = {

	# ───────────────────────────────────────────
	# CẬN CHIẾN
	# ───────────────────────────────────────────
	"dao_gam": {
		"ten":                  "Dao Găm",
		"loai":                 "can_chien",
		"phe":                  "chung",
		"gia":                  0,

		# Sát thương
		"sat_thuong":           45,
		"nhan_sat_thuong_dau":  1.5,
		"tam_tan_cong":         1.8,        # mét

		# Chuột trái / phải
		"chuot_trai":           "chém nhanh",
		"chuot_phai":           "đâm mạnh (sát thương x2)",

		# Di chuyển
		"he_so_toc_do":         1.1,        # nhanh hơn bình thường

		# Không có đạn
		"dan_trong_bang":       0,
		"so_bang_du_phong":     0,
		"thoi_gian_nap":        0.0,
		"kieu_ban":             "can_chien",

		# Recoil / độ chính xác — không áp dụng
		"do_giat_doc":          0.0,
		"do_giat_ngang":        0.0,
		"toc_do_hoi_phuc":      0.0,

		"am_thanh_ban":         "can_chien/dao_dam.wav",
	},

	"ma_tau": {
		"ten":                  "Mã Tấu",
		"loai":                 "can_chien",
		"phe":                  "chung",
		"gia":                  0,

		"sat_thuong":           65,
		"nhan_sat_thuong_dau":  1.5,
		"tam_tan_cong":         2.2,

		"chuot_trai":           "chém rộng",
		"chuot_phai":           "chém mạnh (chậm hơn)",

		"he_so_toc_do":         1.0,

		"dan_trong_bang":       0,
		"so_bang_du_phong":     0,
		"thoi_gian_nap":        0.0,
		"kieu_ban":             "can_chien",

		"do_giat_doc":          0.0,
		"do_giat_ngang":        0.0,
		"toc_do_hoi_phuc":      0.0,

		"am_thanh_ban":         "can_chien/chem_kiem.wav",
	},

	"luoi_le": {
		"ten":                  "Lưỡi Lê",
		"loai":                 "can_chien",
		"phe":                  "chung",
		"gia":                  0,

		"sat_thuong":           55,
		"nhan_sat_thuong_dau":  2.0,
		"tam_tan_cong":         2.0,

		"chuot_trai":           "đâm nhanh",
		"chuot_phai":           "đâm sâu (sát thương cao)",

		"he_so_toc_do":         1.0,

		"dan_trong_bang":       0,
		"so_bang_du_phong":     0,
		"thoi_gian_nap":        0.0,
		"kieu_ban":             "can_chien",

		"do_giat_doc":          0.0,
		"do_giat_ngang":        0.0,
		"toc_do_hoi_phuc":      0.0,

		"am_thanh_ban":         "can_chien/dao_dam.wav",
	},

	# ───────────────────────────────────────────
	# SÚNG LỤC
	# ───────────────────────────────────────────
	"k54": {
		"ten":                  "K54",
		"loai":                 "sung_luc",
		"phe":                  "viet_nam",
		"gia":                  200,

		"sat_thuong":           35,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              40.0,

		"chuot_trai":           "bắn",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       8,
		"so_bang_du_phong":     2,
		"thoi_gian_nap":        1.8,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.3,

		"toc_do_ngam":          0.15,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.6,

		"do_giat_doc":          0.5,
		"do_giat_ngang":        0.2,
		"toc_do_hoi_phuc":      8.0,
		"recoil_khi_di_chuyen": 1.3,
		"recoil_khi_ngam":      0.6,

		"do_chinh_xac_dung":    0.85,
		"do_chinh_xac_di":      0.65,
		"do_chinh_xac_chay":    0.35,
		"do_chinh_xac_ngoi":    0.95,

		"he_so_toc_do":         1.0,

		"am_thanh_ban":         "bersa_pistol.wav",
	},

	"m1911": {
		"ten":                  "M1911",
		"loai":                 "sung_luc",
		"phe":                  "my",
		"gia":                  300,

		"sat_thuong":           38,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              40.0,

		"chuot_trai":           "bắn",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       7,
		"so_bang_du_phong":     2,
		"thoi_gian_nap":        2.0,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.28,

		"toc_do_ngam":          0.15,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.65,

		"do_giat_doc":          0.6,
		"do_giat_ngang":        0.25,
		"toc_do_hoi_phuc":      8.0,
		"recoil_khi_di_chuyen": 1.3,
		"recoil_khi_ngam":      0.6,

		"do_chinh_xac_dung":    0.87,
		"do_chinh_xac_di":      0.65,
		"do_chinh_xac_chay":    0.35,
		"do_chinh_xac_ngoi":    0.95,

		"he_so_toc_do":         1.0,

		"am_thanh_ban":         "m1911.wav",
	},

	# ───────────────────────────────────────────
	# TIỂU LIÊN (SMG)
	# ───────────────────────────────────────────
	"mat49": {
		"ten":                  "MAT-49",
		"loai":                 "tieu_lien",
		"phe":                  "phap",
		"gia":                  1100,

		"sat_thuong":           27,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              60.0,

		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       32,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        2.2,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.07,

		"toc_do_ngam":          0.2,
		"do_zoom_ngam":         68,
		"do_chinh_xac_ngam":    0.7,

		"do_giat_doc":          0.55,
		"do_giat_ngang":        0.3,
		"toc_do_hoi_phuc":      7.0,
		"recoil_khi_di_chuyen": 1.4,
		"recoil_khi_ngam":      0.65,

		"do_chinh_xac_dung":    0.82,
		"do_chinh_xac_di":      0.62,
		"do_chinh_xac_chay":    0.38,
		"do_chinh_xac_ngoi":    0.92,

		"he_so_toc_do":         1.0,

		"am_thanh_ban":         "carl_gustav_smg.wav",
	},

	"k50m": {
		"ten":                  "K50M",
		"loai":                 "tieu_lien",
		"phe":                  "viet_nam",
		"gia":                  1200,

		"sat_thuong":           26,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              60.0,

		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       35,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        2.3,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.075,

		"toc_do_ngam":          0.2,
		"do_zoom_ngam":         68,
		"do_chinh_xac_ngam":    0.68,

		"do_giat_doc":          0.6,
		"do_giat_ngang":        0.35,
		"toc_do_hoi_phuc":      7.0,
		"recoil_khi_di_chuyen": 1.4,
		"recoil_khi_ngam":      0.65,

		"do_chinh_xac_dung":    0.80,
		"do_chinh_xac_di":      0.60,
		"do_chinh_xac_chay":    0.36,
		"do_chinh_xac_ngoi":    0.90,

		"he_so_toc_do":         1.0,

		"am_thanh_ban":         "ppsh.wav",
	},

	# ───────────────────────────────────────────
	# SÚNG TRƯỜNG (RIFLE)
	# ───────────────────────────────────────────
	"mas36": {
		"ten":                  "MAS-36",
		"loai":                 "sung_truong",
		"phe":                  "phap",
		"gia":                  2400,

		"sat_thuong":           80,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              120.0,

		"chuot_trai":           "bắn (bolt-action)",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       5,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        3.5,
		"kieu_ban":             "bolt_action",
		"toc_do_ban":           0.9,

		"toc_do_ngam":          0.3,
		"do_zoom_ngam":         55,
		"do_chinh_xac_ngam":    0.9,

		"do_giat_doc":          1.4,
		"do_giat_ngang":        0.2,
		"toc_do_hoi_phuc":      5.0,
		"recoil_khi_di_chuyen": 1.5,
		"recoil_khi_ngam":      0.5,

		"do_chinh_xac_dung":    0.92,
		"do_chinh_xac_di":      0.60,
		"do_chinh_xac_chay":    0.25,
		"do_chinh_xac_ngoi":    0.97,

		"he_so_toc_do":         0.95,

		"am_thanh_ban":         "enfield_1917.wav",
	},

	"sks": {
		"ten":                  "SKS",
		"loai":                 "sung_truong",
		"phe":                  "viet_nam",
		"gia":                  2000,

		"sat_thuong":           55,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              110.0,

		"chuot_trai":           "bắn bán tự động",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       10,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        2.8,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.22,

		"toc_do_ngam":          0.25,
		"do_zoom_ngam":         60,
		"do_chinh_xac_ngam":    0.85,

		"do_giat_doc":          0.85,
		"do_giat_ngang":        0.2,
		"toc_do_hoi_phuc":      6.0,
		"recoil_khi_di_chuyen": 1.4,
		"recoil_khi_ngam":      0.55,

		"do_chinh_xac_dung":    0.90,
		"do_chinh_xac_di":      0.65,
		"do_chinh_xac_chay":    0.30,
		"do_chinh_xac_ngoi":    0.96,

		"he_so_toc_do":         0.95,

		"am_thanh_ban":         "sks.wav",
	},

	"ak47": {
		"ten":                  "AK-47",
		"loai":                 "sung_truong",
		"phe":                  "viet_nam",
		"gia":                  2700,

		"sat_thuong":           36,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              100.0,

		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       30,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        2.5,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.1,

		"toc_do_ngam":          0.22,
		"do_zoom_ngam":         62,
		"do_chinh_xac_ngam":    0.78,

		"do_giat_doc":          0.9,
		"do_giat_ngang":        0.4,
		"toc_do_hoi_phuc":      6.0,
		"recoil_khi_di_chuyen": 1.5,
		"recoil_khi_ngam":      0.6,

		"do_chinh_xac_dung":    0.85,
		"do_chinh_xac_di":      0.60,
		"do_chinh_xac_chay":    0.28,
		"do_chinh_xac_ngoi":    0.93,

		"he_so_toc_do":         0.95,

		"am_thanh_ban":         "ak47.wav",
	},

	"m16a1": {
		"ten":                  "M16A1",
		"loai":                 "sung_truong",
		"phe":                  "my",
		"gia":                  3100,

		"sat_thuong":           33,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              100.0,

		"chuot_trai":           "bắn burst (3 viên)",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       30,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        2.4,
		"kieu_ban":             "burst",
		"so_vien_burst":        3,
		"toc_do_ban":           0.08,
		"thoi_gian_giua_burst": 0.35,

		"toc_do_ngam":          0.20,
		"do_zoom_ngam":         62,
		"do_chinh_xac_ngam":    0.82,

		"do_giat_doc":          0.75,
		"do_giat_ngang":        0.25,
		"toc_do_hoi_phuc":      7.0,
		"recoil_khi_di_chuyen": 1.4,
		"recoil_khi_ngam":      0.55,

		"do_chinh_xac_dung":    0.88,
		"do_chinh_xac_di":      0.63,
		"do_chinh_xac_chay":    0.30,
		"do_chinh_xac_ngoi":    0.95,

		"he_so_toc_do":         0.95,

		"am_thanh_ban":         "ar15.wav",
	},

	# ───────────────────────────────────────────
	# SÚNG MÁY (LMG)
	# ───────────────────────────────────────────
	"m60": {
		"ten":                  "M60",
		"loai":                 "sung_may",
		"phe":                  "my",
		"gia":                  5200,

		"sat_thuong":           30,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              120.0,

		"chuot_trai":           "bắn tự động (liên tục)",
		"chuot_phai":           "ngắm (ADS — chậm)",

		"dan_trong_bang":       100,
		"so_bang_du_phong":     1,
		"thoi_gian_nap":        5.0,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.08,
		"thoi_gian_khoi_dong":  0.3,

		"toc_do_ngam":          0.45,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.65,

		"do_giat_doc":          0.7,
		"do_giat_ngang":        0.5,
		"toc_do_hoi_phuc":      4.0,
		"recoil_khi_di_chuyen": 1.8,
		"recoil_khi_ngam":      0.7,

		"do_chinh_xac_dung":    0.78,
		"do_chinh_xac_di":      0.45,
		"do_chinh_xac_chay":    0.20,
		"do_chinh_xac_ngoi":    0.88,

		"he_so_toc_do":         0.80,

		"am_thanh_ban":         "minigun_lmg.ogg",
	},

	"rpd": {
		"ten":                  "RPD",
		"loai":                 "sung_may",
		"phe":                  "viet_nam",
		"gia":                  4800,

		"sat_thuong":           28,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              110.0,

		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",

		"dan_trong_bang":       100,
		"so_bang_du_phong":     1,
		"thoi_gian_nap":        4.5,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.085,
		"thoi_gian_khoi_dong":  0.25,

		"toc_do_ngam":          0.4,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.67,

		"do_giat_doc":          0.65,
		"do_giat_ngang":        0.45,
		"toc_do_hoi_phuc":      4.5,
		"recoil_khi_di_chuyen": 1.7,
		"recoil_khi_ngam":      0.7,

		"do_chinh_xac_dung":    0.80,
		"do_chinh_xac_di":      0.48,
		"do_chinh_xac_chay":    0.22,
		"do_chinh_xac_ngoi":    0.90,

		"he_so_toc_do":         0.82,

		"am_thanh_ban":         "minigun_lmg.ogg",
	},

	# ───────────────────────────────────────────
	# BẮN TỈA (SNIPER)
	# ───────────────────────────────────────────
	"mosin": {
		"ten":                  "Mosin-Nagant",
		"loai":                 "ban_tia",
		"phe":                  "viet_nam",
		"gia":                  4750,

		"sat_thuong":           115,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              300.0,

		"chuot_trai":           "bắn (bolt-action)",
		"chuot_phai":           "scope x4",

		"dan_trong_bang":       5,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        4.0,
		"kieu_ban":             "bolt_action",
		"toc_do_ban":           1.5,

		"toc_do_ngam":          0.4,
		"do_zoom_ngam":         25,
		"do_zoom_scope":        25,
		"do_chinh_xac_ngam":    0.97,
		"co_hold_breath":       true,

		"do_giat_doc":          1.8,
		"do_giat_ngang":        0.15,
		"toc_do_hoi_phuc":      4.0,
		"recoil_khi_di_chuyen": 2.0,
		"recoil_khi_ngam":      0.4,

		"do_chinh_xac_dung":    0.95,
		"do_chinh_xac_di":      0.40,
		"do_chinh_xac_chay":    0.10,
		"do_chinh_xac_ngoi":    0.99,

		"he_so_toc_do":         0.90,

		"am_thanh_ban":         "mosin_nagant.wav",
	},

	"svd": {
		"ten":                  "SVD Dragunov",
		"loai":                 "ban_tia",
		"phe":                  "viet_nam",
		"gia":                  5500,

		"sat_thuong":           95,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              300.0,

		"chuot_trai":           "bắn bán tự động",
		"chuot_phai":           "scope x4/x8",

		"dan_trong_bang":       10,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        3.5,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.5,

		"toc_do_ngam":          0.38,
		"do_zoom_ngam":         22,
		"do_zoom_scope":        22,
		"do_chinh_xac_ngam":    0.96,
		"co_hold_breath":       true,

		"do_giat_doc":          1.5,
		"do_giat_ngang":        0.2,
		"toc_do_hoi_phuc":      5.0,
		"recoil_khi_di_chuyen": 1.8,
		"recoil_khi_ngam":      0.4,

		"do_chinh_xac_dung":    0.94,
		"do_chinh_xac_di":      0.42,
		"do_chinh_xac_chay":    0.12,
		"do_chinh_xac_ngoi":    0.98,

		"he_so_toc_do":         0.88,

		"am_thanh_ban":         "savage_10.wav",
	},

	# ───────────────────────────────────────────
	# PHÓNG LỰU
	# ───────────────────────────────────────────
	"m79": {
		"ten":                  "M79",
		"loai":                 "phong_luu",
		"phe":                  "my",
		"gia":                  3500,

		"sat_thuong":           500,
		"nhan_sat_thuong_dau":  1.0,
		"tam_ban":              150.0,
		"ban_kinh_no":          3.5,

		"chuot_trai":           "bắn lựu đạn",
		"chuot_phai":           "ngắm thủ công",

		"dan_trong_bang":       1,
		"so_bang_du_phong":     5,
		"thoi_gian_nap":        3.0,
		"kieu_ban":             "bolt_action",
		"toc_do_ban":           1.2,

		"toc_do_ngam":          0.35,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.70,

		"do_giat_doc":          2.0,
		"do_giat_ngang":        0.3,
		"toc_do_hoi_phuc":      3.0,
		"recoil_khi_di_chuyen": 1.5,
		"recoil_khi_ngam":      0.8,

		"do_chinh_xac_dung":    0.80,
		"do_chinh_xac_di":      0.50,
		"do_chinh_xac_chay":    0.20,
		"do_chinh_xac_ngoi":    0.88,

		"he_so_toc_do":         0.88,

		"am_thanh_ban":         "m79_glauncher.ogg",
	},

	# ───────────────────────────────────────────
	# SÚNG TRƯỜNG BỔ SUNG
	# ───────────────────────────────────────────
	"m1_garand": {
		"ten":                  "M1 Garand",
		"loai":                 "sung_truong",
		"phe":                  "my",
		"gia":                  2200,
		"sat_thuong":           60,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              110.0,
		"chuot_trai":           "bắn bán tự động",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       8,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        2.5,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.2,
		"toc_do_ngam":          0.25,
		"do_zoom_ngam":         60,
		"do_chinh_xac_ngam":    0.87,
		"do_giat_doc":          0.9,
		"do_giat_ngang":        0.2,
		"toc_do_hoi_phuc":      6.0,
		"recoil_khi_di_chuyen": 1.4,
		"recoil_khi_ngam":      0.55,
		"do_chinh_xac_dung":    0.90,
		"do_chinh_xac_di":      0.62,
		"do_chinh_xac_chay":    0.28,
		"do_chinh_xac_ngoi":    0.96,
		"he_so_toc_do":         0.95,
		"am_thanh_ban":         "mosin_nagant.wav",  # TẠM: Mosin cùng caliber heavy WW2; thay khi tìm CC0 M1 Garand riêng
	},

	"m14": {
		"ten":                  "M14",
		"loai":                 "sung_truong",
		"phe":                  "my",
		"gia":                  2900,
		"sat_thuong":           70,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              130.0,
		"chuot_trai":           "bắn bán tự động",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       20,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        2.7,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.18,
		"toc_do_ngam":          0.28,
		"do_zoom_ngam":         58,
		"do_chinh_xac_ngam":    0.88,
		"do_giat_doc":          1.1,
		"do_giat_ngang":        0.25,
		"toc_do_hoi_phuc":      5.5,
		"recoil_khi_di_chuyen": 1.5,
		"recoil_khi_ngam":      0.5,
		"do_chinh_xac_dung":    0.91,
		"do_chinh_xac_di":      0.60,
		"do_chinh_xac_chay":    0.25,
		"do_chinh_xac_ngoi":    0.97,
		"he_so_toc_do":         0.93,
		"am_thanh_ban":         "ar15.wav",
	},

	"car15": {
		"ten":                  "CAR-15",
		"loai":                 "sung_truong",
		"phe":                  "my",
		"gia":                  2500,
		"sat_thuong":           28,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              80.0,
		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       30,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        2.2,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.085,
		"toc_do_ngam":          0.18,
		"do_zoom_ngam":         63,
		"do_chinh_xac_ngam":    0.80,
		"do_giat_doc":          0.7,
		"do_giat_ngang":        0.3,
		"toc_do_hoi_phuc":      7.0,
		"recoil_khi_di_chuyen": 1.35,
		"recoil_khi_ngam":      0.6,
		"do_chinh_xac_dung":    0.83,
		"do_chinh_xac_di":      0.62,
		"do_chinh_xac_chay":    0.32,
		"do_chinh_xac_ngoi":    0.92,
		"he_so_toc_do":         1.0,
		"am_thanh_ban":         "ar15.wav",
	},

	"mas49": {
		"ten":                  "MAS-49",
		"loai":                 "sung_truong",
		"phe":                  "phap",
		"gia":                  2300,
		"sat_thuong":           58,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              115.0,
		"chuot_trai":           "bắn bán tự động",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       10,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        2.6,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.21,
		"toc_do_ngam":          0.25,
		"do_zoom_ngam":         60,
		"do_chinh_xac_ngam":    0.86,
		"do_giat_doc":          0.88,
		"do_giat_ngang":        0.22,
		"toc_do_hoi_phuc":      6.0,
		"recoil_khi_di_chuyen": 1.4,
		"recoil_khi_ngam":      0.55,
		"do_chinh_xac_dung":    0.89,
		"do_chinh_xac_di":      0.63,
		"do_chinh_xac_chay":    0.28,
		"do_chinh_xac_ngoi":    0.95,
		"he_so_toc_do":         0.95,
		"am_thanh_ban":         "ar15.wav",
	},

	# ───────────────────────────────────────────
	# TIỂU LIÊN BỔ SUNG
	# ───────────────────────────────────────────
	"m3_grease_gun": {
		"ten":                  "M3 Grease Gun",
		"loai":                 "tieu_lien",
		"phe":                  "my",
		"gia":                  1000,
		"sat_thuong":           30,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              50.0,
		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       30,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        2.5,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.11,
		"toc_do_ngam":          0.2,
		"do_zoom_ngam":         68,
		"do_chinh_xac_ngam":    0.65,
		"do_giat_doc":          0.5,
		"do_giat_ngang":        0.3,
		"toc_do_hoi_phuc":      7.5,
		"recoil_khi_di_chuyen": 1.35,
		"recoil_khi_ngam":      0.65,
		"do_chinh_xac_dung":    0.78,
		"do_chinh_xac_di":      0.60,
		"do_chinh_xac_chay":    0.38,
		"do_chinh_xac_ngoi":    0.88,
		"he_so_toc_do":         1.0,
		"am_thanh_ban":         "carl_gustav_smg.wav",
	},

	"ppsh41": {
		"ten":                  "PPSh-41",
		"loai":                 "tieu_lien",
		"phe":                  "viet_nam",
		"gia":                  1300,
		"sat_thuong":           25,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              55.0,
		"chuot_trai":           "bắn tự động (nhanh)",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       71,
		"so_bang_du_phong":     2,
		"thoi_gian_nap":        3.0,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.055,
		"toc_do_ngam":          0.2,
		"do_zoom_ngam":         68,
		"do_chinh_xac_ngam":    0.63,
		"do_giat_doc":          0.5,
		"do_giat_ngang":        0.38,
		"toc_do_hoi_phuc":      6.5,
		"recoil_khi_di_chuyen": 1.4,
		"recoil_khi_ngam":      0.65,
		"do_chinh_xac_dung":    0.76,
		"do_chinh_xac_di":      0.58,
		"do_chinh_xac_chay":    0.35,
		"do_chinh_xac_ngoi":    0.86,
		"he_so_toc_do":         1.0,
		"am_thanh_ban":         "ppsh.wav",
	},

	"pps43": {
		"ten":                  "PPS-43",
		"loai":                 "tieu_lien",
		"phe":                  "viet_nam",
		"gia":                  900,
		"sat_thuong":           24,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              50.0,
		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       35,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        2.2,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.08,
		"toc_do_ngam":          0.18,
		"do_zoom_ngam":         68,
		"do_chinh_xac_ngam":    0.65,
		"do_giat_doc":          0.48,
		"do_giat_ngang":        0.28,
		"toc_do_hoi_phuc":      7.0,
		"recoil_khi_di_chuyen": 1.3,
		"recoil_khi_ngam":      0.65,
		"do_chinh_xac_dung":    0.79,
		"do_chinh_xac_di":      0.61,
		"do_chinh_xac_chay":    0.38,
		"do_chinh_xac_ngoi":    0.89,
		"he_so_toc_do":         1.0,
		"am_thanh_ban":         "ppsh.wav",
	},

	# ───────────────────────────────────────────
	# SÚNG MÁY BỔ SUNG
	# ───────────────────────────────────────────
	"fm2429": {
		"ten":                  "FM 24/29",
		"loai":                 "sung_may",
		"phe":                  "phap",
		"gia":                  4500,
		"sat_thuong":           32,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              120.0,
		"chuot_trai":           "bắn tự động",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       25,
		"so_bang_du_phong":     4,
		"thoi_gian_nap":        4.0,
		"kieu_ban":             "tu_dong",
		"toc_do_ban":           0.09,
		"thoi_gian_khoi_dong":  0.2,
		"toc_do_ngam":          0.4,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.68,
		"do_giat_doc":          0.68,
		"do_giat_ngang":        0.42,
		"toc_do_hoi_phuc":      4.5,
		"recoil_khi_di_chuyen": 1.75,
		"recoil_khi_ngam":      0.7,
		"do_chinh_xac_dung":    0.80,
		"do_chinh_xac_di":      0.47,
		"do_chinh_xac_chay":    0.22,
		"do_chinh_xac_ngoi":    0.90,
		"he_so_toc_do":         0.82,
		"am_thanh_ban":         "minigun_lmg.ogg",
	},

	# ───────────────────────────────────────────
	# SÚNG LỤC BỔ SUNG
	# ───────────────────────────────────────────
	"lebel1892": {
		"ten":                  "Lebel 1892",
		"loai":                 "sung_luc",
		"phe":                  "phap",
		"gia":                  150,
		"sat_thuong":           32,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              35.0,
		"chuot_trai":           "bắn (revolver)",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       6,
		"so_bang_du_phong":     3,
		"thoi_gian_nap":        3.5,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.35,
		"toc_do_ngam":          0.15,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.62,
		"do_giat_doc":          0.55,
		"do_giat_ngang":        0.2,
		"toc_do_hoi_phuc":      8.0,
		"recoil_khi_di_chuyen": 1.3,
		"recoil_khi_ngam":      0.6,
		"do_chinh_xac_dung":    0.83,
		"do_chinh_xac_di":      0.62,
		"do_chinh_xac_chay":    0.33,
		"do_chinh_xac_ngoi":    0.93,
		"he_so_toc_do":         1.0,
		"am_thanh_ban":         "ruger_revolver.wav",
	},

	"tt33": {
		"ten":                  "TT-33",
		"loai":                 "sung_luc",
		"phe":                  "viet_nam",
		"gia":                  180,
		"sat_thuong":           34,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              40.0,
		"chuot_trai":           "bắn",
		"chuot_phai":           "ngắm (ADS)",
		"dan_trong_bang":       8,
		"so_bang_du_phong":     2,
		"thoi_gian_nap":        1.9,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.28,
		"toc_do_ngam":          0.15,
		"do_zoom_ngam":         65,
		"do_chinh_xac_ngam":    0.63,
		"do_giat_doc":          0.52,
		"do_giat_ngang":        0.22,
		"toc_do_hoi_phuc":      8.0,
		"recoil_khi_di_chuyen": 1.3,
		"recoil_khi_ngam":      0.6,
		"do_chinh_xac_dung":    0.84,
		"do_chinh_xac_di":      0.63,
		"do_chinh_xac_chay":    0.33,
		"do_chinh_xac_ngoi":    0.93,
		"he_so_toc_do":         1.0,
		"am_thanh_ban":         "cz_pistol.wav",
	},

	# ───────────────────────────────────────────
	# BẮN TỈA BỔ SUNG
	# ───────────────────────────────────────────
	"m21": {
		"ten":                  "M21",
		"loai":                 "ban_tia",
		"phe":                  "my",
		"gia":                  5200,
		"sat_thuong":           90,
		"nhan_sat_thuong_dau":  4.0,
		"tam_ban":              280.0,
		"chuot_trai":           "bắn bán tự động",
		"chuot_phai":           "scope x4/x8",
		"dan_trong_bang":       20,
		"so_bang_du_phong":     2,
		"thoi_gian_nap":        3.2,
		"kieu_ban":             "ban_tu_dong",
		"toc_do_ban":           0.45,
		"toc_do_ngam":          0.38,
		"do_zoom_ngam":         23,
		"do_zoom_scope":        23,
		"do_chinh_xac_ngam":    0.95,
		"co_hold_breath":       true,
		"do_giat_doc":          1.4,
		"do_giat_ngang":        0.18,
		"toc_do_hoi_phuc":      5.0,
		"recoil_khi_di_chuyen": 1.8,
		"recoil_khi_ngam":      0.4,
		"do_chinh_xac_dung":    0.93,
		"do_chinh_xac_di":      0.42,
		"do_chinh_xac_chay":    0.12,
		"do_chinh_xac_ngoi":    0.98,
		"he_so_toc_do":         0.88,
		"am_thanh_ban":         "tikka.wav",
	},

	# ───────────────────────────────────────────
	# ROCKET LAUNCHER
	# ───────────────────────────────────────────
	"rpg7": {
		"ten":                  "RPG-7",
		"loai":                 "phong_luu",
		"phe":                  "viet_nam",
		"gia":                  4500,
		"sat_thuong":           800,
		"nhan_sat_thuong_dau":  1.0,
		"tam_ban":              200.0,
		"ban_kinh_no":          5.0,
		"chuot_trai":           "bắn rocket",
		"chuot_phai":           "ngắm thủ công",
		"dan_trong_bang":       1,
		"so_bang_du_phong":     2,
		"thoi_gian_nap":        4.5,
		"kieu_ban":             "bolt_action",
		"toc_do_ban":           1.5,
		"toc_do_ngam":          0.4,
		"do_zoom_ngam":         60,
		"do_chinh_xac_ngam":    0.75,
		"do_giat_doc":          3.0,
		"do_giat_ngang":        0.5,
		"toc_do_hoi_phuc":      2.0,
		"recoil_khi_di_chuyen": 1.5,
		"recoil_khi_ngam":      0.9,
		"do_chinh_xac_dung":    0.82,
		"do_chinh_xac_di":      0.45,
		"do_chinh_xac_chay":    0.18,
		"do_chinh_xac_ngoi":    0.90,
		"he_so_toc_do":         0.75,
		"am_thanh_ban":         "rpg7_rlauncher.ogg",
	},

	# ───────────────────────────────────────────
	# LỰU ĐẠN (ném tay)
	# ───────────────────────────────────────────
	"luu_dan": {
		"ten":                  "Lựu Đạn",
		"loai":                 "luu_dan",
		"phe":                  "chung",
		"gia":                  300,

		"sat_thuong":           400,
		"nhan_sat_thuong_dau":  1.0,
		"ban_kinh_no":          4.0,
		"thoi_gian_no":         3.0,   # giây sau khi ném

		"chuot_trai":           "ném",
		"chuot_phai":           "giữ để tính lực ném",

		"dan_trong_bang":       1,
		"so_bang_du_phong":     2,
		"thoi_gian_nap":        0.0,
		"kieu_ban":             "nem",

		"do_giat_doc":          0.0,
		"do_giat_ngang":        0.0,
		"toc_do_hoi_phuc":      0.0,

		"he_so_toc_do":         1.0,
	},
}
