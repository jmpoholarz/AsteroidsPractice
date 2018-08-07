extends Area2D

var velocity = Vector2(0,0)

func _ready():
	# Init random number generator
	randomize()
	# Set initial velocity
	velocity.x = randi() % 40 + 10
	velocity.y = randi() % 40 + 10
	pass

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_AsteroidSmall_area_shape_entered(area_id, area, area_shape, self_shape):
	# Remove at the end of the grame
	queue_free()
