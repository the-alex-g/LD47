extends KinematicBody

export var speed := 200
var left_boundary:float
var right_boundary:float
var back_boundary:float
var front_boundary:float

func _physics_process(delta):
	var velocity := Vector2.ZERO
	if Input.is_action_pressed("Forward"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.y -= 1
	if Input.is_action_pressed("Right"):
		velocity.y += 1
	if Input.is_action_pressed("Backward"):
		velocity.x -= 1
	velocity = velocity.normalized()*speed*delta
	var error = move_and_slide_with_snap(Vector3(velocity.x, 0, velocity.y), Vector3(0,-1,0))
	if get_global_transform().origin.z >= right_boundary:
		global_transform.origin.z = left_boundary+1
	if get_global_transform().origin.z <= left_boundary:
		global_transform.origin.z = right_boundary-1
	if get_global_transform().origin.x >= front_boundary:
		global_transform.origin.x = back_boundary+1
	if get_global_transform().origin.x <= back_boundary:
		global_transform.origin.x = front_boundary-1
