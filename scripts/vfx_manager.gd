extends Node

# ============================================================
# VFX MANAGER — quản lý hiệu ứng visual cho bắn / trúng / máu
# Autoload tên: VfxManager
# ============================================================

const SO_DECAL_TOI_DA = 60        # giới hạn bullet hole decal
const THOI_GIAN_BLOOD_DECAL = 30.0
const THOI_GIAN_TRACER = 0.045
const TRACER_TI_LE_HIEN = 0.5     # 50% phát có tracer (giống quân đội thật, đỡ obnoxious)

var _decals_dan: Array = []        # FIFO queue cho bullet hole

# ──────────── BULLET IMPACT (trúng tường) ────────────
func bullet_impact(vi_tri: Vector3, phap_tuyen: Vector3, scene_root: Node):
	# 1) Spark particle (tia lửa nóng)
	_tao_spark(vi_tri, phap_tuyen, scene_root)
	# 2) Dust cloud (bụi xám)
	_tao_dust(vi_tri, phap_tuyen, scene_root)
	# 3) Decal lỗ đạn lưu trên tường
	_tao_bullet_hole(vi_tri, phap_tuyen, scene_root)
	# 4) Ánh sáng lóe ngắn
	_tao_impact_flash(vi_tri, phap_tuyen, scene_root)

func _tao_spark(vi_tri: Vector3, phap_tuyen: Vector3, scene_root: Node):
	var p = GPUParticles3D.new()
	var proc = ParticleProcessMaterial.new()
	proc.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_POINT
	proc.direction = phap_tuyen
	proc.spread = 35.0
	proc.initial_velocity_min = 4.0
	proc.initial_velocity_max = 9.0
	proc.gravity = Vector3(0, -9.8, 0)
	proc.scale_min = 0.015
	proc.scale_max = 0.04
	proc.color = Color(1.0, 0.85, 0.35, 1.0)
	# Curve emission
	var grad = Gradient.new()
	grad.add_point(0.0, Color(1.0, 0.95, 0.5, 1))
	grad.add_point(0.5, Color(1.0, 0.5, 0.1, 1))
	grad.add_point(1.0, Color(0.5, 0.1, 0.05, 0))
	var grad_tex = GradientTexture1D.new()
	grad_tex.gradient = grad
	proc.color_ramp = grad_tex
	p.process_material = proc
	var mesh = SphereMesh.new()
	mesh.radius = 0.012
	mesh.height = 0.024
	mesh.radial_segments = 4
	mesh.rings = 2
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color(1, 0.85, 0.4, 1)
	mat.emission_enabled = true
	mat.emission = Color(1, 0.7, 0.2, 1)
	mat.emission_energy_multiplier = 4.0
	mesh.material = mat
	p.draw_pass_1 = mesh
	p.amount = 14
	p.lifetime = 0.45
	p.one_shot = true
	p.explosiveness = 0.9
	scene_root.add_child(p)
	p.global_position = vi_tri + phap_tuyen * 0.02
	p.emitting = true
	_huy_sau(p, 1.2)

func _tao_dust(vi_tri: Vector3, phap_tuyen: Vector3, scene_root: Node):
	var p = GPUParticles3D.new()
	var proc = ParticleProcessMaterial.new()
	proc.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_POINT
	proc.direction = phap_tuyen
	proc.spread = 45.0
	proc.initial_velocity_min = 0.4
	proc.initial_velocity_max = 1.2
	proc.gravity = Vector3(0, -0.5, 0)
	proc.scale_min = 0.06
	proc.scale_max = 0.18
	# fade out
	var grad = Gradient.new()
	grad.add_point(0.0, Color(0.85, 0.78, 0.7, 0.5))
	grad.add_point(1.0, Color(0.6, 0.55, 0.5, 0.0))
	var grad_tex = GradientTexture1D.new()
	grad_tex.gradient = grad
	proc.color_ramp = grad_tex
	p.process_material = proc
	var mesh = QuadMesh.new()
	mesh.size = Vector2(0.18, 0.18)
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color = Color(0.85, 0.78, 0.7, 0.5)
	mat.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED
	mesh.material = mat
	p.draw_pass_1 = mesh
	p.amount = 8
	p.lifetime = 0.7
	p.one_shot = true
	p.explosiveness = 0.85
	scene_root.add_child(p)
	p.global_position = vi_tri + phap_tuyen * 0.02
	p.emitting = true
	_huy_sau(p, 1.5)

func _tao_bullet_hole(vi_tri: Vector3, phap_tuyen: Vector3, scene_root: Node):
	var decal = Decal.new()
	decal.size = Vector3(0.12, 0.04, 0.12)
	# Texture albedo cho lỗ đạn — dùng noise đơn giản
	var img_tex = _texture_lo_dan()
	decal.texture_albedo = img_tex
	decal.albedo_mix = 1.0
	decal.modulate = Color(0.05, 0.05, 0.05, 1.0)
	scene_root.add_child(decal)
	# Hướng decal vuông góc với surface — decal project xuống -Z của chính nó,
	# muốn -Z trỏ VÀO tường thì look_at point ngược chiều phap_tuyen
	decal.global_position = vi_tri + phap_tuyen * 0.005
	if phap_tuyen.length() > 0.001:
		var truc_up = Vector3.UP if abs(phap_tuyen.y) < 0.95 else Vector3.RIGHT
		decal.look_at(decal.global_position - phap_tuyen, truc_up)
	# FIFO: nếu quá SO_DECAL_TOI_DA, xóa decal cũ nhất
	_decals_dan.append(decal)
	while _decals_dan.size() > SO_DECAL_TOI_DA:
		var cu = _decals_dan.pop_front()
		if is_instance_valid(cu):
			cu.queue_free()

func _texture_lo_dan() -> Texture2D:
	# Tạo texture procedural đơn giản — vòng tròn đen viền nâu
	var img = Image.create(64, 64, false, Image.FORMAT_RGBA8)
	for y in range(64):
		for x in range(64):
			var dx = (x - 32) / 32.0
			var dy = (y - 32) / 32.0
			var r = sqrt(dx * dx + dy * dy)
			if r < 0.25:
				img.set_pixel(x, y, Color(0.02, 0.02, 0.02, 1))
			elif r < 0.45:
				var t = (r - 0.25) / 0.2
				img.set_pixel(x, y, Color(0.05 + t * 0.1, 0.04 + t * 0.05, 0.03, 1))
			elif r < 0.55:
				var t = (r - 0.45) / 0.1
				img.set_pixel(x, y, Color(0.15, 0.1, 0.07, 1.0 - t))
			else:
				img.set_pixel(x, y, Color(0, 0, 0, 0))
	var tex = ImageTexture.create_from_image(img)
	return tex

func _tao_impact_flash(vi_tri: Vector3, phap_tuyen: Vector3, scene_root: Node):
	var light = OmniLight3D.new()
	light.light_color = Color(1.0, 0.7, 0.3, 1)
	light.light_energy = 2.5
	light.omni_range = 1.5
	scene_root.add_child(light)
	light.global_position = vi_tri + phap_tuyen * 0.1
	var tween = light.create_tween()
	tween.tween_property(light, "light_energy", 0.0, 0.12)
	tween.tween_callback(light.queue_free)

# ──────────── BLOOD (trúng địch) ────────────
func blood_splatter(vi_tri: Vector3, phap_tuyen: Vector3, scene_root: Node):
	var p = GPUParticles3D.new()
	var proc = ParticleProcessMaterial.new()
	proc.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_POINT
	proc.direction = phap_tuyen
	proc.spread = 60.0
	proc.initial_velocity_min = 2.5
	proc.initial_velocity_max = 6.5
	proc.gravity = Vector3(0, -9.0, 0)
	proc.scale_min = 0.02
	proc.scale_max = 0.06
	var grad = Gradient.new()
	grad.add_point(0.0, Color(0.8, 0.05, 0.05, 1))
	grad.add_point(0.7, Color(0.4, 0.02, 0.02, 1))
	grad.add_point(1.0, Color(0.2, 0.0, 0.0, 0))
	var grad_tex = GradientTexture1D.new()
	grad_tex.gradient = grad
	proc.color_ramp = grad_tex
	p.process_material = proc
	var mesh = SphereMesh.new()
	mesh.radius = 0.025
	mesh.height = 0.05
	mesh.radial_segments = 5
	mesh.rings = 3
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mat.albedo_color = Color(0.7, 0.04, 0.04, 1)
	mat.metallic_specular = 0.6
	mat.roughness = 0.3
	mesh.material = mat
	p.draw_pass_1 = mesh
	p.amount = 22
	p.lifetime = 0.6
	p.one_shot = true
	p.explosiveness = 0.95
	scene_root.add_child(p)
	p.global_position = vi_tri
	p.emitting = true
	_huy_sau(p, 1.4)

# ──────────── TRACER (đường đạn) ────────────
func tracer(tu: Vector3, den: Vector3, scene_root: Node):
	# Quân đội thật chỉ 1 trên 5 viên có tracer — em random 50% để đỡ chói mắt
	if randf() > TRACER_TI_LE_HIEN:
		return
	var line = MeshInstance3D.new()
	var khoang_cach = tu.distance_to(den)
	if khoang_cach < 0.5:
		return
	var mesh = CylinderMesh.new()
	mesh.top_radius = 0.0035            # mảnh ~3mm
	mesh.bottom_radius = 0.0015         # taper về điểm trúng
	mesh.height = khoang_cach
	mesh.radial_segments = 4
	mesh.rings = 1
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color = Color(1, 0.85, 0.45, 0.55)
	mat.emission_enabled = true
	mat.emission = Color(1, 0.8, 0.35, 1)
	mat.emission_energy_multiplier = 2.2
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mesh.material = mat
	line.mesh = mesh
	scene_root.add_child(line)
	# Đặt cylinder giữa tu-den, xoay cho axis Y (mặc định CylinderMesh) trùng hướng
	line.global_position = (tu + den) * 0.5
	var huong = (den - tu).normalized()
	# Quaternion từ Vector3.UP đến huong — an toàn cả khi parallel
	var q = Quaternion(Vector3.UP, huong)
	line.transform.basis = Basis(q)
	# Fade out
	var tween = line.create_tween()
	tween.tween_property(mat, "albedo_color:a", 0.0, THOI_GIAN_TRACER)
	tween.tween_callback(line.queue_free)

# ──────────── MUZZLE SMOKE (khói nòng) ────────────
func muzzle_smoke(vi_tri: Vector3, huong: Vector3, scene_root: Node):
	var p = GPUParticles3D.new()
	var proc = ParticleProcessMaterial.new()
	proc.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_POINT
	proc.direction = huong
	proc.spread = 25.0
	proc.initial_velocity_min = 1.0
	proc.initial_velocity_max = 2.5
	proc.gravity = Vector3(0, 0.3, 0)
	proc.scale_min = 0.05
	proc.scale_max = 0.13
	var grad = Gradient.new()
	grad.add_point(0.0, Color(0.95, 0.92, 0.85, 0.55))
	grad.add_point(1.0, Color(0.8, 0.78, 0.72, 0.0))
	var grad_tex = GradientTexture1D.new()
	grad_tex.gradient = grad
	proc.color_ramp = grad_tex
	p.process_material = proc
	var mesh = QuadMesh.new()
	mesh.size = Vector2(0.18, 0.18)
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color = Color(0.95, 0.92, 0.85, 0.55)
	mat.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED
	mesh.material = mat
	p.draw_pass_1 = mesh
	p.amount = 6
	p.lifetime = 0.55
	p.one_shot = true
	p.explosiveness = 0.85
	scene_root.add_child(p)
	p.global_position = vi_tri
	p.emitting = true
	_huy_sau(p, 1.2)

# ──────────── HELPER ────────────
func _huy_sau(node: Node, giay: float):
	var t = get_tree().create_timer(giay)
	t.timeout.connect(func():
		if is_instance_valid(node):
			node.queue_free()
	)
