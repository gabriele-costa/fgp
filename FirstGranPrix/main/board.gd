extends Sprite

const pen_tile = [12,22]
const pen_turns = [2,1]

# Called when the node enters the scene tree for the first time.
func _ready():
	Model.reset()
	pass # Replace with function body.

func move_car(steps):
	var car = Model.turn
	var current_position = Model.tile[car]
	var current_sprite = get_current(car, current_position)
	var next_sprite = get_next(car, current_position, steps)
	current_sprite.set_visible(false)
	next_sprite.set_visible(true)
	Model.tile[car] = current_position + steps
	
	# penalty system
	var index = pen_tile.find(Model.tile[car])
	if index >= 0:
		Model.penalty[car] = pen_turns[index]
	

# Cars start from tile 26
func get_current(car, tile):
	if tile == 0:
		return get_child(50 + car)
	else:
		return get_child((tile - 1) * 2 + car)

# After the finish line, cars stop at tile 1
func get_next(car, tile, steps):
	var next_tile = tile + steps
	if next_tile > 26:
		return get_child(car)
	else:
		return get_child((next_tile - 1) * 2 + car)
