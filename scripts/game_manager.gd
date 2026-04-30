extends Node

# Phe địch của map này — set qua Inspector cho từng map
# Hợp lệ: "my", "phap"
@export var phe_dich: String = "my"

func _ready():
	TranDau.set_tran(phe_dich)

	var round_mgr = get_node_or_null("RoundManager")
	var player = get_node_or_null("Player")
	if round_mgr == null or player == null:
		return

	var hud = player.get_node_or_null("HUD")
	if hud == null:
		return

	round_mgr.cap_nhat_thoi_gian.connect(hud.cap_nhat_thoi_gian)
	round_mgr.on_ket_thuc_hieu_p.connect(func(thang):
		var info_dich = TranDau.thong_tin_dich()
		var ten_doi = TranDau.TEN_DOI_A if thang == "A" else info_dich["ten_doi"]
		var mau = TranDau.MAU_DOI_A if thang == "A" else info_dich["mau_doi"]
		hud.hien_thong_bao(ten_doi + " THẮNG HIỆP!", mau)
		hud.cap_nhat_diem(round_mgr.diem_doi_a, round_mgr.diem_doi_b, round_mgr.hieu_p_hien_tai)
	)
	round_mgr.hieu_p_moi.connect(func():
		hud.cap_nhat_diem(round_mgr.diem_doi_a, round_mgr.diem_doi_b, round_mgr.hieu_p_hien_tai)
	)
