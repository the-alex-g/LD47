extends Scenery

onready var tween:Tween = $Tween
onready var light:OmniLight = $Spatial/MeshInstance/OmniLight

func fadeout():
	var _error = tween.interpolate_property(light, "light_energy", 1, 0, 1)
	var _error2 = tween.start()

func fadein():
	var _error = tween.interpolate_property(light, "light_energy", 0, 1, 1)
	var _error2 = tween.start()
