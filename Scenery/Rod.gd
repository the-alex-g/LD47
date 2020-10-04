extends Scenery


onready var light:OmniLight = $Spatial/MeshInstance/OmniLight
onready var noise:AudioStreamPlayer3D = $AudioStreamPlayer3D
onready var tween:Tween = $Tween
signal lit

func _on_VisibilityNotifier_camera_entered(_camera):
	set_new_location()


func _on_Area_area_entered(area):
	if area.name == "Player" and light.visible == false:
		fadein()
		light.visible = true
		emit_signal("lit")
		noise.play()

func fadeout():
	var _error = tween.interpolate_property(light, "light_energy", 1, 0, 1)
	var _error2 = tween.start()

func fadein():
	var _error = tween.interpolate_property(light, "light_energy", 0, 1, 1)
	var _error2 = tween.start()
