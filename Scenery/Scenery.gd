extends Spatial


onready var secondary_rotation_point:Spatial = $Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	_set_new_location()


func _set_new_location():
	rotation_degrees.y = rand_range(1,360)
	secondary_rotation_point.rotation_degrees.x = rand_range(1,360)


func _on_VisibilityNotifier_camera_exited(camera):
	_set_new_location()
