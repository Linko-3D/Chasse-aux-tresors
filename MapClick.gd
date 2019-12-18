extends Position2D

var dragMouse = false

func _input(event):
	if dragMouse:
		if event is InputEventMouseMotion:
			position += event.relative

func _on_Map_button_down():
	dragMouse = true

func _on_Map_button_up():
	dragMouse = false
