extends Polygon2D

var selected = false
@export var placed = false
@export var original_position: Vector2
var snap_rect: Rect2
@export var sphere: CollisionShape2D

var area: Area2D
var collision_polygon_2d: CollisionPolygon2D

func _ready():
	adjust_polygon()
	setup_area()
	original_position = global_position
	snap_rect = Rect2(original_position - Vector2(50, 50), Vector2(100, 100))

func adjust_polygon():
	var array = polygon
	for i in array.size():
		var new_v = array[i] + offset
		array[i] = new_v
	polygon = array
	offset = Vector2(0, 0)


func setup_area():
	area = Area2D.new()
	collision_polygon_2d = CollisionPolygon2D.new()
	collision_polygon_2d.polygon = polygon
	area.add_child(collision_polygon_2d)
	area.input_pickable = true
	area.input_event.connect(_on_area_2d_input_event)
	add_child(area)


func _process(delta):
	if selected:
		follow_mouse()


func follow_mouse():
	var mouse_position = get_global_mouse_position()
	global_position = mouse_position


func _on_area_2d_input_event(viewport, event, shape_idx):
	var mouse_event := event as InputEventMouseButton
	if (mouse_event and
		mouse_event.button_index == MOUSE_BUTTON_LEFT):
			if mouse_event.pressed and not placed:
				selected = true
			else:
				selected = false
				if (snap_rect.has_point(global_position)):
					global_position = original_position
					placed = true

func move_piece(vector: Vector2):
	original_position += vector
	snap_rect = Rect2(original_position - Vector2(50, 50), Vector2(100, 100))
	if placed:
		global_position += vector
