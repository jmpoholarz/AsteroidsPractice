extends Node

var LargeAsteroid = load('res://AsteroidLarge.tscn')
var MediumAsteroid = load('res://AsteroidMedium.tscn')
var SmallAsteroid = load('res://AsteroidSmall.tscn')
var Ship = load('res://Ship.tscn')

var LEVELS = [
	[0,3,0],
	[1,2,0],
	[2,2,0],
	[3,0,0],
	[4,0,0],
	[5,0,0]
]
var MAX_LEVEL = LEVELS.size()

func _ready():
	# Start first level
	add_child(Ship.instance())
	load_level(1)

func load_level(level):
	# Keep playing last level if reached last level
	if level > MAX_LEVEL:
		level = MAX_LEVEL
	# Decrease level by 1 to account for 0 indexing
	level -= 1
	# Load large asteroids
	for i in range(LEVELS[level][0]):
		add_child(LargeAsteroid.instance())
	# Load medium asteroids
	for i in range(LEVELS[level][1]):
		add_child(MediumAsteroid.instance())
	# Load small asteroids
	for i in range(LEVELS[level][2]):
		add_child(SmallAsteroid.instance())
