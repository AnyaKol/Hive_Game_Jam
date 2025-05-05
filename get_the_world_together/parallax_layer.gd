extends ParallaxBackground

var offset_vector: Vector2
var max_offset: Vector2 = Vector2(500, 0)
var min_offset: Vector2 = Vector2(-500, 0)

func _input(event):
	if event.is_action_pressed("move_left"):
		offset_vector = Vector2(100, 0)
		move_map(offset_vector)

	if event.is_action_pressed("move_right"):
		offset_vector = Vector2(-100, 0)
		move_map(offset_vector)

func move_map(Vector2):
	if ((scroll_offset > min_offset and offset_vector < Vector2(0, 0))
		or (scroll_offset < max_offset and offset_vector > Vector2(0, 0))):
		scroll_offset += offset_vector
		var pieces = $Polygons.get_children()
		for i in pieces.size():
			pieces[i].move_piece(offset_vector)
