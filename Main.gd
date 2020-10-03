extends MeshInstance

const shroom := preload("res://Mushroom.tscn")

onready var player = $Player
onready var left:Position3D = $Boundaries/Left
onready var right:Position3D = $Boundaries/Right
onready var front:Position3D = $Boundaries/Front
onready var back:Position3D = $Boundaries/Back
onready var Shrooms:Spatial = $Shrooms

func _ready():
	randomize()
	player.left_boundary = left.get_global_transform().origin.z
	player.right_boundary = right.get_global_transform().origin.z
	player.front_boundary = front.get_global_transform().origin.x
	player.back_boundary = back.get_global_transform().origin.x
	for _x in 100:
		var Shroom = shroom.instance()
		Shroom.transform.origin = Vector3(rand_range(-100, 100), 0, rand_range(-20,20))
		Shrooms.add_child(Shroom)
