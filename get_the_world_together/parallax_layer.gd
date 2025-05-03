extends ParallaxLayer

func map_move(delta):
	var direction = Input.get_axis("move_left", "move_right")

	if direction:
		position.x = direction * 300
	else:
		position.x = move_toward(position.x, 0, 300)
