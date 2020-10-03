extends CSGTorus

var _lit_rods := 0
signal GO
signal lit
signal player_dead
signal won

func _on_Rod_lit():
	_lit_rods += 1
	if _lit_rods == 3:
		emit_signal("GO")
		$Camera.current = true
	emit_signal("lit")

func _on_Player_lighterup():
	$OmniLight.visible = true
	yield(get_tree().create_timer(2), "timeout")
	emit_signal("won")

func _on_Player_dead():
	emit_signal("player_dead")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Main/MainMenu.tscn")
