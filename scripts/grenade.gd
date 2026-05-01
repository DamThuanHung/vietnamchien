extends RigidBody3D

const BAN_KINH_NO = 5.0
const SAT_THUONG_TOI_DA = 180
const THOI_GIAN_NO = 3.0
const DUONG_DAN_AM_THANH_NO = "res://assets/sounds/luu_dan/no_lon.ogg"

var da_no = false

func _ready():
	await get_tree().create_timer(THOI_GIAN_NO).timeout
	_no()

func nem(huong: Vector3, luc: float = 14.0):
	linear_velocity = huong * luc + Vector3.UP * 5.0
	angular_velocity = Vector3(randf_range(-5, 5), randf_range(-5, 5), randf_range(-5, 5))

func _no():
	if da_no:
		return
	da_no = true

	var cac_muc_tieu = []
	cac_muc_tieu.append_array(get_tree().get_nodes_in_group("nguoi_choi"))
	cac_muc_tieu.append_array(get_tree().get_nodes_in_group("dich"))

	for muc_tieu in cac_muc_tieu:
		if not is_instance_valid(muc_tieu):
			continue
		var khoang_cach = global_position.distance_to(muc_tieu.global_position)
		if khoang_cach <= BAN_KINH_NO:
			var he_so = 1.0 - (khoang_cach / BAN_KINH_NO)
			var sat_thuong = int(SAT_THUONG_TOI_DA * he_so)
			if muc_tieu.has_method("nhan_sat_thuong"):
				muc_tieu.nhan_sat_thuong(sat_thuong)
			elif muc_tieu.has_node("HUD"):
				muc_tieu.get_node("HUD").nhan_sat_thuong(sat_thuong)

	var anh_sang = OmniLight3D.new()
	anh_sang.light_color = Color(1, 0.6, 0.1, 1)
	anh_sang.light_energy = 12.0
	anh_sang.omni_range = 10.0
	get_tree().current_scene.add_child(anh_sang)
	anh_sang.global_position = global_position

	_phat_am_thanh_no()

	await get_tree().create_timer(0.4).timeout
	anh_sang.queue_free()
	queue_free()

func _phat_am_thanh_no():
	if not ResourceLoader.exists(DUONG_DAN_AM_THANH_NO):
		return
	var am_thanh = AudioStreamPlayer3D.new()
	am_thanh.stream = load(DUONG_DAN_AM_THANH_NO)
	am_thanh.unit_size = 25.0
	am_thanh.max_db = 8.0
	get_tree().current_scene.add_child(am_thanh)
	am_thanh.global_position = global_position
	am_thanh.play()
	am_thanh.finished.connect(am_thanh.queue_free)
