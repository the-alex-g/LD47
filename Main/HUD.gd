extends CanvasLayer

onready var tracker:AnimatedSprite = $AnimatedSprite
var rods_lit := 0

func _on_Main_lit():
	rods_lit += 1

func _process(_delta):
	tracker.play(str(rods_lit))
