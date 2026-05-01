extends Node3D

var sat_thuong = 36
var tam_ban = 100.0
var toc_do_ban = 0.1
var dan_hien_tai = 30
var dan_toi_da = 30
var ten_sung = "AK-47"
var do_giat = 0.8
var thoi_gian_nap = 2.5
var loai_sung = "sung_truong"

var co_the_ban = true
var dang_nap = false
var dang_ngam = false
var camera: Camera3D
var muzzle_flash: OmniLight3D
var player: CharacterBody3D
var buy_menu: CanvasLayer

const DUONG_DAN_AM_THANH_GOC = "res://assets/sounds/"
var am_thanh_ban_player: AudioStreamPlayer3D
var stream_ban: AudioStream = null

# Recoil
var giat_hien_tai = Vector2.ZERO
var giat_muc_tieu = Vector2.ZERO
var so_phat_lien_tiep = 0

# ADS
var fov_mac_dinh = 75.0
var toc_do_ads = 0.22
var do_zoom_ads = 62.0

func _ready():
	camera = get_parent()
	muzzle_flash = $MuzzleFlash
	player = get_parent().get_parent()
	buy_menu = player.get_node_or_null("BuyMenu")
	am_thanh_ban_player = AudioStreamPlayer3D.new()
	am_thanh_ban_player.unit_size = 30.0
	am_thanh_ban_player.max_db = 6.0
	add_child(am_thanh_ban_player)

func _process(delta):
	if get_tree().paused:
		return
	_xu_ly_recoil(delta)
	_xu_ly_ads(delta)

func _xu_ly_recoil(delta):
	giat_muc_tieu = giat_muc_tieu.lerp(Vector2.ZERO, delta * 6.0)
	var delta_giat = giat_muc_tieu - giat_hien_tai
	giat_hien_tai = giat_muc_tieu
	if delta_giat.length() > 0.0001:
		camera.rotate_x(-delta_giat.y * 0.01)
		player.rotate_y(-delta_giat.x * 0.01)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2.2, PI/2.2)

func _xu_ly_ads(delta):
	var fov_muc_tieu = do_zoom_ads if dang_ngam else fov_mac_dinh
	camera.fov = lerp(camera.fov, fov_muc_tieu, delta / toc_do_ads)

func trang_bi_sung(data: Dictionary):
	sat_thuong = data["sat_thuong"]
	tam_ban = data.get("tam_ban", 100.0)
	toc_do_ban = data.get("toc_do_ban", 0.1)
	dan_toi_da = data.get("dan_trong_bang", 30)
	dan_hien_tai = dan_toi_da
	ten_sung = data["ten"]
	loai_sung = data.get("loai", "sung_truong")
	thoi_gian_nap = data.get("thoi_gian_nap", 2.5)
	toc_do_ads = data.get("toc_do_ngam", 0.22)
	do_zoom_ads = data.get("do_zoom_ngam", 62.0)
	do_giat = _tinh_do_giat(loai_sung)
	so_phat_lien_tiep = 0
	dang_ngam = false
	dang_nap = false
	co_the_ban = true
	_nap_am_thanh_ban(data.get("am_thanh_ban", ""))
	_cap_nhat_hud_dan()

func _nap_am_thanh_ban(ten_file: String):
	if ten_file == "":
		stream_ban = null
		am_thanh_ban_player.stream = null
		return
	var duong_dan = DUONG_DAN_AM_THANH_GOC
	if "/" in ten_file:
		duong_dan += ten_file
	else:
		duong_dan += "sung/" + ten_file
	if ResourceLoader.exists(duong_dan):
		stream_ban = load(duong_dan)
		am_thanh_ban_player.stream = stream_ban
	else:
		stream_ban = null
		am_thanh_ban_player.stream = null

func _tinh_do_giat(loai: String) -> float:
	match loai:
		"can_chien": return 0.0
		"sung_luc":  return 0.5
		"tieu_lien": return 0.6
		"sung_truong": return 0.9
		"sung_may":  return 0.7
		"ban_tia":   return 1.8
		"phong_luu": return 2.0
		_: return 0.8

func _input(event):
	if get_tree().paused:
		return
	# Không xử lý input khi đang mở buy menu
	if buy_menu and buy_menu.dang_mo:
		return
	# Không bắn khi đang cầm lựu đạn
	if player.get("dang_cam_luu_dan"):
		return
	# Bắn
	if event.is_action_pressed("ban") and co_the_ban and not dang_nap:
		if dan_hien_tai > 0:
			ban()
		else:
			_tu_dong_nap()
	if event.is_action_released("ban"):
		so_phat_lien_tiep = 0

	# Nạp đạn
	if event.is_action_pressed("nap_dan") and not dang_nap:
		if dan_hien_tai < dan_toi_da:
			nap_dan()

	# ADS chuột phải
	if event.is_action_pressed("ngam"):
		dang_ngam = true
	if event.is_action_released("ngam"):
		dang_ngam = false

func ban():
	co_the_ban = false
	dan_hien_tai -= 1
	so_phat_lien_tiep += 1
	muzzle_flash.flash()
	if stream_ban:
		am_thanh_ban_player.pitch_scale = randf_range(0.95, 1.05)
		am_thanh_ban_player.play()
	_ap_dung_recoil()
	_cap_nhat_hud_dan()

	var hud = player.get_node_or_null("HUD")
	if hud:
		hud.no_crosshair()

	var space_state = get_world_3d().direct_space_state
	var tam_man_hinh = get_viewport().get_visible_rect().size / 2

	var do_lech = min(so_phat_lien_tiep * 0.003, 0.05)
	if dang_ngam:
		do_lech *= 0.4
	var lech = Vector2(randf_range(-do_lech, do_lech), randf_range(-do_lech, do_lech))
	var diem_ban = tam_man_hinh + lech * 1000.0

	var tu = camera.project_ray_origin(diem_ban)
	var den = tu + camera.project_ray_normal(diem_ban) * tam_ban

	var query = PhysicsRayQueryParameters3D.create(tu, den)
	query.exclude = [player]
	var ket_qua = space_state.intersect_ray(query)

	if ket_qua:
		if ket_qua.collider.has_method("nhan_sat_thuong"):
			ket_qua.collider.nhan_sat_thuong(sat_thuong)
			if ket_qua.collider.get("dang_song") == false:
				if hud:
					var ten_dich = ket_qua.collider.get("ten_hien_thi")
					if ten_dich == null or ten_dich == "":
						ten_dich = ket_qua.collider.name
					hud.them_kill(ten_dich, loai_sung)
		tao_hieu_ung_trung_dan(ket_qua.position, ket_qua.normal)

	await get_tree().create_timer(toc_do_ban).timeout
	co_the_ban = true

func nap_dan():
	if dan_toi_da == 0 or dang_nap:
		return
	dang_nap = true
	co_the_ban = false
	dang_ngam = false

	var hud = player.get_node_or_null("HUD")
	if hud and hud.has_method("hien_thong_bao_nap"):
		hud.hien_thong_bao_nap(thoi_gian_nap)

	await get_tree().create_timer(thoi_gian_nap).timeout
	dan_hien_tai = dan_toi_da
	dang_nap = false
	co_the_ban = true
	_cap_nhat_hud_dan()

func _tu_dong_nap():
	if not dang_nap:
		nap_dan()

func _ap_dung_recoil():
	var nhan = 0.6 if dang_ngam else 1.0
	var tang_giat = do_giat * nhan * (1.0 + so_phat_lien_tiep * 0.05)
	giat_muc_tieu += Vector2(
		randf_range(-tang_giat * 0.3, tang_giat * 0.3),
		tang_giat
	)

func _cap_nhat_hud_dan():
	var hud = player.get_node_or_null("HUD")
	if hud and hud.has_method("cap_nhat_dan"):
		hud.cap_nhat_dan(dan_hien_tai, dan_toi_da, ten_sung, dang_nap)

func tao_hieu_ung_trung_dan(vi_tri, phap_tuyen):
	var dau_dan = MeshInstance3D.new()
	var hinh_cau = SphereMesh.new()
	hinh_cau.radius = 0.03
	hinh_cau.height = 0.06
	dau_dan.mesh = hinh_cau
	var vat_lieu = StandardMaterial3D.new()
	vat_lieu.albedo_color = Color(1, 0.8, 0, 1)
	vat_lieu.emission_enabled = true
	vat_lieu.emission = Color(1, 0.6, 0, 1)
	vat_lieu.emission_energy_multiplier = 2.0
	dau_dan.set_surface_override_material(0, vat_lieu)
	get_tree().current_scene.add_child(dau_dan)
	dau_dan.global_position = vi_tri + phap_tuyen * 0.01
	await get_tree().create_timer(2.0).timeout
	dau_dan.queue_free()
