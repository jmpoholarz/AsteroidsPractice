extends Area2D

var smallAsteroid = load('res://AsteroidSmall.tscn')

signal increase_score(amount)

var velocity = Vector2(0,0)
var childSeed

func _ready():
	# Set node connections
	var mainNode = get_node("/root/Main")
	connect("increase_score", mainNode, "increase_score")
	
	# Init random number generator
	randomize()
	# Set initial velocity
	velocity.x = randi() % 30 + 10
	velocity.y = randi() % 30 + 10
	var xSign = randi() % 2
	var ySign = randi() % 2
	if xSign == 0:
		velocity.x *= -1
	if ySign == 0:
		velocity.y *= -1
	# Init number of asteroids when destroyed
	childSeed = randi() % 100
	pass

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_AsteroidMedium_area_shape_entered(area_id, area, area_shape, self_shape):
	# Add small asteroids
	create_asteroids()
	# Remove at the end of the grame
	queue_free()
	# Increase score
	emit_signal("increase_score", 50)

func create_asteroids():
	# 10% chance of 4 asteroids
	if childSeed >= 90:
		var small4 = smallAsteroid.instance()
		small4.position = position
		get_parent().add_child(small4)
	# 20% chance of 3 asteroids
	if childSeed >= 70:
		var small3 = smallAsteroid.instance()
		small3.position = position
		get_parent().add_child(small3)
	# 50% chance of 2 asteroids
	if childSeed >= 20:
		var small2 = smallAsteroid.instance()
		small2.position = position
		get_parent().add_child(small2)
	# 20% chance of 1 asteroid
	if childSeed >= 0:
		var small1 = smallAsteroid.instance()
		small1.position = position
		get_parent().add_child(small1)