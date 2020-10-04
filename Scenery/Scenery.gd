class_name Scenery
extends Spatial


onready var secondary_rotation_point:Spatial = $Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_new_location()


func set_new_location():
	rotation_degrees.y = rand_range(1,360)
	secondary_rotation_point.rotation_degrees.x = rand_range(1,360)


func _on_VisibilityNotifier_camera_exited(_camera):
	set_new_location()
