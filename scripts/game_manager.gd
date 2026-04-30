extends Node

func _ready():
	var round_mgr = get_node_or_null("RoundManager")
	var player = get_node_or_null("Player")
	if round_mgr == null or player == null:
		return

	var hud = player.get_node_or_null("HUD")
	if hud == null:
		return

	round_mgr.cap_nhat_thoi_gian.connect(hud.cap_nhat_thoi_gian)
	round_mgr.on_ket_thuc_hieu_p.connect(func(thang):
		var noi_dung = "ĐỘI %s THẮNG HIỆP!" % thang
		var mau = Color(0.3, 0.7, 1.0) if thang == "A" else Color(1.0, 0.3, 0.3)
		hud.hien_thong_bao(noi_dung, mau)
		hud.cap_nhat_diem(round_mgr.diem_doi_a, round_mgr.diem_doi_b, round_mgr.hieu_p_hien_tai)
	)
	round_mgr.hieu_p_moi.connect(func():
		hud.cap_nhat_diem(round_mgr.diem_doi_a, round_mgr.diem_doi_b, round_mgr.hieu_p_hien_tai)
	)
