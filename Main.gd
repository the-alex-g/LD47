extends MeshInstance

onready var player = $Player
onready var left:Position3D = $Boundaries/Left
onready var right:Position3D = $Boundaries/Right
onready var front:Position3D = $Boundaries/Front
onready var back:Position3D = $Boundaries/Back

func _ready():
	player.left_boundary = left.get_global_transform().origin.z
	player.right_boundary = right.get_global_transform().origin.z
	player.front_boundary = front.get_global_transform().origin.x
	player.back_boundary = back.get_global_transform().origin.x
