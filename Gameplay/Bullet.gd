extends Area2D

var velocity = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	pass
	
func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_Timer_timeout():
	get_parent().remove_child(self)

func _on_Bullet_area_shape_entered(area_id, area, area_shape, self_shape):
	# Remove at the end of the frame
	queue_free()
