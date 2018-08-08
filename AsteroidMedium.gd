extends Area2D

var smallAsteroid = load('res://AsteroidSmall.tscn')

var velocity = Vector2(0,0)

func _ready():
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
	pass

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_AsteroidMedium_area_shape_entered(area_id, area, area_shape, self_shape):
	var small1 = smallAsteroid.instance()
	small1.position.x = position.x
	small1.position.y = position.y
	get_parent().add_child(small1)
	# Remove at the end of the grame
	queue_free()
