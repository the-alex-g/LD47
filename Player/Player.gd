class_name Player
extends Spatial

onready var secondary_rotation_point:Spatial = $Spatial
onready var tween:Tween = $Tween
onready var dead:AudioStreamPlayer3D = $AudioStreamPlayer3D
var GO := false
var primary_rotation:float = 0
var secondary_rotation:float = 0
signal lighterup
signal dead

func _process(_delta):
	if not GO:
		stop()
		if Input.is_action_pressed("Forward"):
			secondary_rotation -=1
		if Input.is_action_pressed("Backward"):
			secondary_rotation += 1
		if Input.is_action_pressed("Left"):
			primary_rotation -= 1
		if Input.is_action_pressed("Right"):
			primary_rotation += 1
	var dir := Vector2(primary_rotation, secondary_rotation).normalized()
	secondary_rotation_point.rotation_degrees.x += dir.y
	rotation_degrees.y += dir.x

func _on_Main_GO():
	GO = true
	stop()
	secondary_rotation_point.rotation_degrees.x = int(secondary_rotation_point.rotation_degrees.x)%360
	$Spatial/MeshInstance/Camera.current = false
	var _error = tween.interpolate_property(secondary_rotation_point, "rotation_degrees", Vector3(secondary_rotation_point.rotation_degrees.x,0,0), Vector3(-90,0,0), 1)
	var _error2 = tween.start()
	yield(get_tree().create_timer(1), "timeout")
	var _error3 = tween.interpolate_property(secondary_rotation_point, "translation", Vector3(0,0,secondary_rotation_point.translation.z), Vector3(0,0,0.5), 3)
	var _error4 = tween.start()
	yield(get_tree().create_timer(3), "timeout")
	emit_signal("lighterup")

func stop():
	primary_rotation = 0
	secondary_rotation = 0

func _on_Player_area_entered(area):
	if area.name == "Enemy" and not GO:
		GO = true
		stop()
		emit_signal("dead")
		dead.play()
