extends CSGTorus

signal start
signal lit_rod
signal won
signal lose
onready var tween:Tween = $Tween
onready var player = $Player
onready var playercamera:Camera = $Player/Spatial/MeshInstance/Camera
onready var camera:Camera = $Camera
onready var rods:Spatial = $Rods
onready var mainmenurods:Spatial = $MainMenuRods
onready var worldlight:OmniLight = $OmniLight
var lit_rods := 0

func _ready():
	load_main()

func load_main():
	var _error = tween.interpolate_property(worldlight, "light_energy", null,0,0.5)
	var _error2 = tween.start()
	player.start = false
	player.reset()
	rods.hide()
	for rod in rods.get_children():
		rod.set_new_location()
		rod.light.hide()
	for rod in mainmenurods.get_children():
		rod.show()
		rod.set_new_location()
		rod.fadein()
	lit_rods = 0

func _on_HUD_play():
	var _error = tween.interpolate_property(camera, "translation", Vector3(3.53, 2.272, 0), Vector3(0,0,1), 2)
	var _error2 = tween.start()
	var _error3 = tween.interpolate_property(camera, "rotation_degrees", Vector3(-37.9, 90, -90), Vector3(0,180,-180), 2)
	var _error4 = tween.start()
	yield(get_tree().create_timer(2), "timeout")
	for rod in mainmenurods.get_children():
		rod.fadeout()
	yield(get_tree().create_timer(1), "timeout")
	for rod in mainmenurods.get_children():
		rod.hide()
	player.start = true
	camera.current = false
	playercamera.current = true
	rods.show()
	emit_signal("start")

func _on_Rod_lit():
	lit_rods += 1
	emit_signal("lit_rod")
	if lit_rods == 3:
		playercamera.current = false
		camera.current = true
		emit_signal("won")
		var _error = tween.interpolate_property(camera, "translation", playercamera.global_transform.origin, Vector3(0,3,0), 2)
		var _error2 = tween.start()
		var _error3 = tween.interpolate_property(camera, "rotation_degrees", playercamera.rotation_degrees, Vector3(-90,0,0), 2)
		var _error4 = tween.start()

func _on_Player_lighterup():
	var _error = tween.interpolate_property(worldlight, "light_energy", 0,1,0.5)
	var _error2 = tween.start()

func _on_HUD_return_to_main():
	playercamera.current = false
	camera.current = true
	var _error = tween.interpolate_property(camera, "translation", null, Vector3(3.53, 2.272, 0), 2)
	var _error2 = tween.start()
	var _error3 = tween.interpolate_property(camera, "rotation_degrees", null, Vector3(-37.9, 90, -90), 2)
	var _error4 = tween.start()
	yield(get_tree().create_timer(2), "timeout")
	load_main()

func _on_Player_dead():
	emit_signal("lose")
