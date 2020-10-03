extends CSGTorus

var _lit_rods := 2
signal GO
signal lit
signal player_dead
signal won
onready var tween:Tween = $Tween
onready var camera:Camera = $Camera
onready var playercamera:Camera = $Player/Spatial/MeshInstance/Camera

func _on_Rod_lit():
	_lit_rods += 1
	if _lit_rods == 3:
		emit_signal("GO")
		$Camera.current = true
		camera.global_transform.origin = playercamera.global_transform.origin
		var _error = tween.interpolate_property(camera, "translation", playercamera.global_transform.origin, Vector3(0,3,0), 2)
		var _error2 = tween.start()
		var _error3 = tween.interpolate_property(camera, "rotation_degrees", playercamera.rotation_degrees, Vector3(-90,0,0), 2)
		var _error4 = tween.start()
	emit_signal("lit")

func _on_Player_lighterup():
	$OmniLight.visible = true
	yield(get_tree().create_timer(2), "timeout")
	emit_signal("won")

func _on_Player_dead():
	emit_signal("player_dead")
	yield(get_tree().create_timer(2), "timeout")
	var _error = get_tree().change_scene("res://Main/MainMenu.tscn")
