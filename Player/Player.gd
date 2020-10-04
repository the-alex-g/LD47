class_name Player
extends Spatial

onready var secondary_rotation_point:Spatial = $Spatial
onready var tween:Tween = $Tween
onready var dead:AudioStreamPlayer3D = $AudioStreamPlayer3D
var start := false
var primary_rotation:float = 0
var secondary_rotation:float = 0
var farg := Vector3.ZERO
var BLARG := Vector3.ZERO
var arg := Vector3.ZERO
var MARG := Vector3.ZERO
signal lighterup
signal dead

func _ready():
	farg = rotation_degrees
	BLARG = secondary_rotation_point.rotation_degrees
	arg = secondary_rotation_point.translation
	MARG = $Spatial/MeshInstance.translation

func reset():
	rotation_degrees = farg
	secondary_rotation_point.rotation_degrees = BLARG
	secondary_rotation_point.translation = arg
	$Spatial/MeshInstance.translation.y = 0.5

func _process(_delta):
	if start:
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

func _input(event):
	if start:
		var thingie:InputEventMouseButton = event as InputEventMouseButton
		if thingie && event.is_pressed():
			if event.position.x < 540 and event.position.x > 460 and event.position.y < 280:
				Input.action_press("Forward")
			elif event.position.x < 540 and event.position.x > 460 and event.position.y > 360:
				Input.action_press("backward")
			if event.position.y < 360 and event.position.y > 280 and event.position.x < 460:
				Input.action_press("Left")
			elif event.position.y < 360 and event.position.y > 280 and event.position.x > 540:
				Input.action_press("Right")
		if thingie && not event.is_pressed():
			if event.position.x < 540 and event.position.x > 460 and event.position.y < 280:
				Input.action_release("Forward")
			elif event.position.x < 540 and event.position.x > 460 and event.position.y > 360:
				Input.action_release("backward")
			if event.position.y < 360 and event.position.y > 280 and event.position.x < 460:
				Input.action_release("Left")
			elif event.position.y < 360 and event.position.y > 280 and event.position.x > 540:
				Input.action_release("Right")

func _on_Main_won():
	start = false
	stop()
	secondary_rotation_point.rotation_degrees.x = int(secondary_rotation_point.rotation_degrees.x)%360
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
	if area.name == "Enemy" and start:
		start = false
		stop()
		emit_signal("dead")
		dead.play()
