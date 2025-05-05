extends Area2D

var sectors = [Vector2(-1, -1), Vector2(1, -1), Vector2(-1, 1), Vector2(1, 1)]

func _ready():
	shuffle_pieces()


func shuffle_pieces():
	var viewport = get_viewport_rect().size
	var rng = RandomNumberGenerator.new()
	var area_rect = $ParallaxBackground/ParallaxLayer/map.get_rect()
	var pieces = $ParallaxBackground/Polygons.get_children()
	var sphere = $ParallaxBackground/Area2D/CollisionShape2D
	for i in pieces.size():
		var piece = pieces[i]
		piece.sphere = sphere
		var yes = rng.randi_range(0, 1)
		if yes != 1:
			piece.placed = true
			continue
		var sector = sectors[rng.randi_range(0, 3)]
		var x = rng.randi_range(100, viewport.x - 100)
		var y = rng.randi_range(100, viewport.y - 100)
		var vector = Vector2(x, y)
		if area_rect.has_point(vector):
			vector = vector - area_rect.size / 4 * sector
		piece.global_position = vector
