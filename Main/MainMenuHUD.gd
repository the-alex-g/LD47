extends CanvasLayer

onready var pressed:AudioStreamPlayer = $AudioStreamPlayer

func _on_Button_pressed():
	pressed.play()
	yield(get_tree().create_timer(0.5), "timeout")
	var _error = get_tree().change_scene("res://Main/Main.tscn")
