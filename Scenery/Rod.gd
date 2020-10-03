extends Scenery


onready var light:OmniLight = $Spatial/MeshInstance/OmniLight
signal lit

func _on_VisibilityNotifier_camera_entered(_camera):
	_set_new_location()


func _on_Area_area_entered(area):
	if area.name == "Player" and light.visible == false:
		light.visible = true
		emit_signal("lit")
