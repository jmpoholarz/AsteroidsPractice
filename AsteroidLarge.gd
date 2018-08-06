extends Area2D

var mediumAsteroid = load('res://AsteroidMedium.tscn')
var velocity = Vector2(0,0)

func _ready():
	# Seed random number
	randomize()
	# Set initial direction and velocity
	var direction = randi() % 360
	velocity.x = randi() % 20 + 10
	velocity.y = randi() % 20 + 10
	pass

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_AsteroidLarge_body_entered(body):
	print("body entered")
	print(body)
	var med1 = mediumAsteroid.instance()
	med1.position.x = position.x
	med1.position.y = position.y
	get_parent().add_child(med1)
	get_parent().remove_child(self)


func _on_AsteroidLarge_area_entered(area):
	print("area entered")
	get_parent().add_child(mediumAsteroid.instance())
	get_parent().remove_child(self) 


func _on_AsteroidLarge_area_shape_entered(area_id, area, area_shape, self_shape):
	print("Area shape entered")
	pass # replace with function body


func _on_AsteroidLarge_body_shape_entered(body_id, body, body_shape, area_shape):
	print("body shape entered")
	pass # replace with function body
