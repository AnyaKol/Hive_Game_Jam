
extends Node

var dragging = false
var	original = Vector2()
var id = 5
var drop_spots

func _ready():
	drop_spots = get_tree().get_nodes_in_group("drops")
		
func _process(_delta):
	if dragging:
		var mouse_pos = get_viewport().get_mouse_position()
		self.position = Vector2(mouse_pos.x, mouse_pos.y)

func _on_button_button_down() -> void:
	dragging = true
	var mouse_pos = get_viewport().get_mouse_position()
	original = Vector2(mouse_pos.x, mouse_pos.y)
	print("click")
		
func _on_button_button_up() -> void:
	dragging = false
	var found = false;
	for d in drop_spots:
		if d.get_node("CollisionShape2D").has_overlapping_areas() and d.has_overlapping_areas().has(self.get_node("CollisionShape2D")):
			var mouse_pos = get_viewport().get_mouse_position()
			self.position = Vector2(mouse_pos.x, mouse_pos.y)
			found = true
	if !found:
		self.position = original
	print ("off")
