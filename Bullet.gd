extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	get_parent().remove_child(self)


func _on_Bullet_body_entered(body):
	print("bullet body entered")
	pass # replace with function body


func _on_Bullet_body_shape_entered(body_id, body, body_shape, local_shape):
	print("bullet body shape entered")
	pass # replace with function body
