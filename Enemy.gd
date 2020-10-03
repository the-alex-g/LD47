class_name Enemy
extends Spatial

var primary_rotation:float
var secondary_rotation:float
onready var scuttle:AnimationPlayer = $AnimationPlayer
onready var secondary_rotation_point:Spatial = $Spatial

func _ready():
	randomize()
	rotation_degrees.y = rand_range(1,360)
	secondary_rotation_point.rotation_degrees.x = rand_range(1,360)
	primary_rotation = (randi()%3)-1
	secondary_rotation = (randi()%3)-1

func _process(_delta):
	var dir := Vector2(primary_rotation, secondary_rotation).normalized()
	secondary_rotation_point.rotation_degrees.x += dir.y*0.5
	rotation_degrees.y += dir.x*0.5

func _on_Timer_timeout():
	primary_rotation = (randi()%3)-1
	secondary_rotation = (randi()%3)-1
	if primary_rotation == 0 and secondary_rotation == 0:
		scuttle.play("Idle")
	else:
		scuttle.play("Walk")
