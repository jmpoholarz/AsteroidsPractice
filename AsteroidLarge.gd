extends Area2D

var mediumAsteroid = load('res://AsteroidMedium.tscn')

func _ready():
	# Called every time the node is added to the scene.
	
	# Seed random number
	randomize()
	var direction = randi() % 360
	$RigidBody2D.linear_velocity.x = randi() % 10
	$RigidBody2D.linear_velocity.y = randi() % 10
	pass

func _process(delta):
	pass


func _on_AsteroidLarge_body_entered(body):
	get_parent().add_child(mediumAsteroid.instance())
	get_parent().remove_child(self)


func _on_AsteroidLarge_area_entered(area):
	get_parent().add_child(mediumAsteroid.instance())
	get_parent().remove_child(self) 
