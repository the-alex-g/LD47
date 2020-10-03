extends Node

onready var music:AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	music.play()
