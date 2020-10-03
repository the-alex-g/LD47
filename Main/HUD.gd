extends CanvasLayer

onready var tracker:AnimatedSprite = $AnimatedSprite
onready var demoralizing_message:Label = $Label
var rods_lit := 0

func _on_Main_lit():
	rods_lit += 1

func _process(_delta):
	tracker.play(str(rods_lit))

func _on_Main_player_dead():
	demoralizing_message.visible = true
