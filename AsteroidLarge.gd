extends Area2D

var mediumAsteroid = load('res://AsteroidMedium.tscn')
var velocity = Vector2(0,0)

func _ready():
	# Seed random number
	randomize()
	# Set initial velocity
	velocity.x = randi() % 20 + 10
	velocity.y = randi() % 20 + 10
	var xSign = randi() % 2
	var ySign = randi() % 2
	if xSign == 0:
		velocity.x *= -1
	if ySign == 0:
		velocity.y *= -1
	# TODO: Make direction not only positive
	pass

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_AsteroidLarge_area_shape_entered(area_id, area, area_shape, self_shape):	
	var med1 = mediumAsteroid.instance()
	med1.position.x = position.x
	med1.position.y = position.y
	get_parent().add_child(med1)
	# Remove at the end of the frame
	queue_free()
	