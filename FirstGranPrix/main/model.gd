extends Node

# constants
const RED = 0 
const BLUE = 1
const NTILES = 26

# variables
var turn = RED      # First player is RED
var tile = [0,0]    # Position of RED and BLUE
var penalty = [0,0] # penalty turns

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize() # this is to initialize the RNG using system clock

func reset():
	turn = RED
	tile = [0,0]
	penalty = [0,0]

func has_penalty(player):
	return penalty[player] > 0

func sub_penalty(player):
	penalty[player] -= 1 # equivalent to penalty[p] = penalty[p] - 1

func add_penalty(player,nturns):
	penalty[player] += nturns

func roll():
	return rng.randi_range(1,6)

func swap():
	if turn == RED:
		turn = BLUE
	else:
		turn = RED

