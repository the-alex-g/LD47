extends CanvasLayer

onready var pressed:AudioStreamPlayer = $AudioStreamPlayer
onready var back:Button = $Node2D/Back
onready var story:Button = $VBoxContainer/Story
onready var play:Button = $VBoxContainer/Play
onready var main:VBoxContainer = $VBoxContainer
onready var fluff:Node2D = $Node2D

func _ready():
	toggle_fluff(false)

func _on_Button_pressed():
	pressed.play()
	yield(get_tree().create_timer(0.5), "timeout")
	var _error = get_tree().change_scene("res://Main/Main.tscn")

func _on_Button2_pressed():
	pressed.play()
	toggle_fluff(true)

func toggle_fluff(boolean:bool):
	back.disabled = !boolean
	story.disabled = boolean
	play.disabled = boolean
	fluff.visible = boolean
	main.visible = !boolean

func _on_Back_pressed():
	pressed.play()
	toggle_fluff(false)
