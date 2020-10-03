extends Spatial


onready var secondary_rotation_point:Spatial = $Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rotation_degrees.y = rand_range(1,360)
	secondary_rotation_point.rotation_degrees.x = rand_range(1,360)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
