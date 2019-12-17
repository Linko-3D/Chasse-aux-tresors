extends Area2D


func _process(delta):
	set_position(get_viewport().get_mouse_position())



func _on_Map_input_event(viewport, event, shape_idx):
	print("a")
	if event is InputEventMouseButton:
		if event.is_pressed():
			print("click")
