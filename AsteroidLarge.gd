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
	print("body entered")
	get_parent().add_child(mediumAsteroid.instance())
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
