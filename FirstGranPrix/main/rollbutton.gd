extends TextureButton

# Animation constants
const car_delay = 1.5
const roll_delay = 0.1
const rolls = 10
const epsilon = 0.2

# alternative: onready var dice = get_children()
var dice

# Called when the node enters the scene tree for the first time.
func _ready():
	dice = get_children()

func on_pressed():
	self.disabled = true # prevent multiple rolls
	
	# STEP 1: roll dice
	var steps = Model.roll()
	
	# STEP 2: play dice animation
	yield(dice_animation(steps - 1), "completed")
	
	# STEP 3: move player car on the board
	yield(move_car(steps), "completed")
	
	if gameover():
		get_tree().change_scene("res://end/end.tscn")
		return
	
	# STEP 4: swap turn
	swap()
	
	self.disabled = false # ready for next round

# This function is for dice animation
# input:
# - last: the last face to appear
# output:
# - nothing
func dice_animation(last):
	for i in range(rolls):
		var d = Model.roll() - 1  # arrays start at 0!
		dice[d].set_visible(true)
		yield(get_tree().create_timer(roll_delay), "timeout")
		dice[d].set_visible(false)
	dice[last].set_visible(true)

# This function is for car movement animation
func move_car(steps):
	get_parent().move_car(steps)
	yield(get_tree().create_timer(car_delay), "timeout")
	dice[steps-1].set_visible(false)
	#yield(get_tree(), "idle_frame")

# This function is for turn swap animation
func swap():
	var turn_cars = get_parent().get_node("turn_node").get_children()
	turn_cars[Model.turn].visible = false
	Model.swap()
	turn_cars[Model.turn].visible = true
	
	# handle penalties
	if Model.penalty[Model.turn] > 0:
		Model.penalty[Model.turn] -= 1
		swap() # Recursive function!

# ruturns true when the race is over
func gameover():
	return Model.tile[Model.RED] >= Model.NTILES or Model.tile[Model.BLUE] >= Model.NTILES  
