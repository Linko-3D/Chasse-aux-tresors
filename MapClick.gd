extends Position2D

var dragMouse = false

func _process(delta):
	if dragMouse:
		set_position(get_viewport().get_mouse_position())

func _on_Map_button_down():
	dragMouse = true

func _on_Map_button_up():
	dragMouse = false
