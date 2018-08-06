extends Area2D

var velocity = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta
