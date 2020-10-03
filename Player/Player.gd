class_name Player
extends Spatial

onready var secondary_rotation_point:Spatial = $Spatial
#onready var camera:Camera = $Spatial/Camera

func _physics_process(delta):
	var primary_rotation:float
	var secondary_rotation:float
	if Input.is_action_pressed("Left"):
		secondary_rotation -=1
	if Input.is_action_pressed("Right"):
		secondary_rotation += 1
	if Input.is_action_pressed("Backward"):
		primary_rotation -= 1
	if Input.is_action_pressed("Forward"):
		primary_rotation += 1
	secondary_rotation_point.rotation_degrees.x += secondary_rotation
	rotation_degrees.y += primary_rotation
