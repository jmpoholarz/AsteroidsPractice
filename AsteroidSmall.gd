extends Area2D

signal increase_score(amount)

var velocity = Vector2(0,0)

func _ready():
	# Connect signals
	var mainNode = get_node("/root/Main")
	connect("increase_score", mainNode, "increase_score")
	# Init random number generator
	randomize()
	# Set initial velocity
	velocity.x = randi() % 40 + 10
	velocity.y = randi() % 40 + 10
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

func _on_AsteroidSmall_area_shape_entered(area_id, area, area_shape, self_shape):
	# Remove at the end of the grame
	queue_free()
	# Increase score
	emit_signal("increase_score", 20)
