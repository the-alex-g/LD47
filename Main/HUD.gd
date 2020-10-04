extends CanvasLayer

onready var main_menu:Control = $MainMenu
onready var gameplay:Control = $GamePlay
onready var back:Button = $MainMenu/Node2D/Back
onready var play:Button = $MainMenu/VBoxContainer/Play
onready var story:Button = $MainMenu/VBoxContainer/Story
onready var fluff:Node2D = $MainMenu/Node2D
onready var main:VBoxContainer = $MainMenu/VBoxContainer
onready var pressed:AudioStreamPlayer = $AudioStreamPlayer
onready var message:Label = $GamePlay/Label
onready var _icon:AnimatedSprite = $GamePlay/AnimatedSprite
onready var tween:Tween = $Tween
var lit_rods := 0
signal play
signal return_to_main

func _ready():
	load_main()

func _process(_delta):
	_icon.play(str(lit_rods))

func load_main():
	gameplay.hide()
	var _error = tween.interpolate_property(main_menu, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1)
	var _error2 = tween.start()
	main_menu.show()
	toggle_story(false)
	message.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func toggle_story(b:bool):
	enable_story(b)
	fluff.visible = b
	main.visible = !b

func enable_story(b:bool):
	back.disabled = !b
	play.disabled = b
	story.disabled = b

func _on_Story_pressed():
	pressed.play()
	toggle_story(true)

func _on_Back_pressed():
	pressed.play()
	toggle_story(false)

func _on_Play_pressed():
	pressed.play()
	var _error = tween.interpolate_property(main_menu, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1)
	var _error2 = tween.start()
	enable_story(true)
	back.disabled = true
	emit_signal("play")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	yield(get_tree().create_timer(1), "timeout")
	main_menu.hide()

func _on_MainMenu_start():
	var _error = tween.interpolate_property(gameplay, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1)
	var _error2 = tween.start()
	gameplay.show()

func _on_MainMenu_won():
	yield(get_tree().create_timer(4), "timeout")
	message.text = "You have illuminated the inky darkness"
	message.show()
	yield(get_tree().create_timer(2), "timeout")
	emit_signal("return_to_main")
	var _error = tween.interpolate_property(gameplay, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1)
	var _error2 = tween.start()
	yield(get_tree().create_timer(2), "timeout")
	load_main()

func _on_MainMenu_lose():
	message.text = "You have failed to light the darkness"
	message.show()
	yield(get_tree().create_timer(2), "timeout")
	emit_signal("return_to_main")
	var _error = tween.interpolate_property(gameplay, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1)
	var _error2 = tween.start()
	yield(get_tree().create_timer(2), "timeout")
	load_main()

func _on_MainMenu_lit_rod():
	lit_rods += 1
