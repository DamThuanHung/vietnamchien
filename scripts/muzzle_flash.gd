extends OmniLight3D

# Muzzle flash AAA — multi-layer:
#   1) Ánh sáng nháy mạnh (light energy curve)
#   2) Sprite plane vàng cam ở nòng (1 frame ngắn)
#   3) Khói nòng (qua VfxManager)
# Khi gun.gd gọi flash() → tất cả phát đồng thời

@onready var sprite_flash: MeshInstance3D = null
var _khoi_tao_xong = false

func _ready():
	light_energy = 0.0
	light_color = Color(1.0, 0.85, 0.5, 1)
	omni_range = 4.5
	omni_attenuation = 1.8
	_tao_sprite_flash()
	_khoi_tao_xong = true

func _tao_sprite_flash():
	sprite_flash = MeshInstance3D.new()
	var quad = QuadMesh.new()
	quad.size = Vector2(0.35, 0.35)
	sprite_flash.mesh = quad
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color = Color(1.0, 0.85, 0.5, 0.0)
	mat.emission_enabled = true
	mat.emission = Color(1.0, 0.7, 0.3, 1)
	mat.emission_energy_multiplier = 8.0
	mat.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED
	mat.no_depth_test = true
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	quad.material = mat
	add_child(sprite_flash)
	sprite_flash.visible = false

func flash():
	if not _khoi_tao_xong:
		return
	# Layer 1: ánh sáng — peak ngay rồi fade
	light_energy = 6.0
	# Layer 2: sprite — random scale + rotation cho biến thể
	if sprite_flash:
		sprite_flash.visible = true
		var ti_le = randf_range(0.85, 1.25)
		sprite_flash.scale = Vector3(ti_le, ti_le, ti_le)
	# Layer 3: khói nòng (qua VfxManager autoload)
	var huong = -global_transform.basis.z
	var scene = get_tree().current_scene
	if scene:
		VfxManager.muzzle_smoke(global_position + huong * 0.15, huong, scene)
	# Tween fade
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "light_energy", 0.0, 0.08)
	if sprite_flash:
		var mat = sprite_flash.mesh.material as StandardMaterial3D
		if mat:
			mat.albedo_color.a = 1.0
			tween.tween_property(mat, "albedo_color:a", 0.0, 0.06)
		tween.chain().tween_callback(func():
			if is_instance_valid(sprite_flash):
				sprite_flash.visible = false
		)
