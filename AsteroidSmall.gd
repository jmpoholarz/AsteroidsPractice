extends Area2D

signal increase_score(amount)

var particleEmitter = load('res://AsteroidParticleEmitter.tscn')

var pathToTextureA = 'res://Assets/asteroid0a.png'
var pathToTextureB = 'res://Assets/asteroid0b.png'
var pathToTextureC = 'res://Assets/asteroid0c.png'
var pathToTextureD = 'res://Assets/asteroid0d.png'

var velocity = Vector2(0,0)

func _ready():
	# Connect signals
	var mainNode = get_node("/root/Main/Screen/Play")
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
	# Init random graphic
	load_graphic(randi() % 4)

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_AsteroidSmall_area_shape_entered(area_id, area, area_shape, self_shape):
	# Create one-shot particle emitter
	var particles = particleEmitter.instance()
	particles.position = position
	particles.amount = 4
	get_parent().add_child(particles)
	# Increase score
	emit_signal("increase_score", 20)
	# Remove at the end of the grame
	queue_free()


func load_graphic(index):
	if index == 0:
		$Sprite.texture = load(pathToTextureA)
	elif index == 1:
		$Sprite.texture = load(pathToTextureB)
	elif index == 2:
		$Sprite.texture = load(pathToTextureC)
	elif index == 3:
		$Sprite.texture = load(pathToTextureD)

