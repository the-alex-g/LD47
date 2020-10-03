extends CanvasLayer

onready var tracker:AnimatedSprite = $AnimatedSprite
onready var _message:Label = $Label
var rods_lit := 0

func _on_Main_lit():
	rods_lit += 1

func _process(_delta):
	tracker.play(str(rods_lit))

func _on_Main_player_dead():
	_message.text = "You have failed to light the darkness"
	_message.visible = true

func _on_Main_won():
	_message.text = "You have illuminated the inky void"
	_message.visible = true
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Main/MainMenu.tscn")
