extends Area2D

var mediumAsteroid = load('res://AsteroidMedium.tscn')
var particleEmitter = load('res://AsteroidParticleEmitter.tscn')

var pathToTextureA = 'res://Assets/asteroid2a.png'
var pathToTextureB = 'res://Assets/asteroid2b.png'
var pathToTextureC = 'res://Assets/asteroid2c.png'
var pathToTextureD = 'res://Assets/asteroid2d.png'

signal increase_score(amount)

var velocity = Vector2(0,0)
var childSeed
var amount = 100

func _ready():
	# Set node connections
	var mainNode = get_node("/root/Main/Screen/Play")
	connect("increase_score", mainNode, "increase_score")
	
	# Seed random number
	randomize()
	# Set initial velocity
	velocity.x = randi() % 20 + 10
	velocity.y = randi() % 20 + 10
	var xSign = randi() % 2
	var ySign = randi() % 2
	if xSign == 0:
		velocity.x *= -1
	if ySign == 0:
		velocity.y *= -1
	# Init number of asteroids when destroyed
	childSeed = randi() % 100
	# Init random graphic
	load_graphic(randi() % 4)

func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func _on_AsteroidLarge_area_shape_entered(area_id, area, area_shape, self_shape):	
	# Add Medium Asteroids
	create_asteroids()
	# Create one-shot particle emitter
	var particles = particleEmitter.instance()
	particles.position = position
	particles.amount = 12
	get_parent().add_child(particles)
	# Increase score
	emit_signal("increase_score", 100)
	# Remove at the end of the frame
	queue_free()


func create_asteroids():
	# 20% chance of 4 asteroids
	if childSeed >= 80:
		var med4 = mediumAsteroid.instance()
		med4.position = position
		get_parent().add_child(med4)
	# 60% chance of 3 asteroids
	if childSeed >= 20:
		var med3 = mediumAsteroid.instance()
		med3.position = position
		get_parent().add_child(med3)
	# 20% chance of 2 asteroids
	if childSeed >= 0:
		var med1 = mediumAsteroid.instance()
		var med2 = mediumAsteroid.instance()
		med1.position = position
		med2.position = position
		get_parent().add_child(med1)
		get_parent().add_child(med2)
		

func load_graphic(index):
	if index == 0:
		$Sprite.texture = load(pathToTextureA)
	elif index == 1:
		$Sprite.texture = load(pathToTextureB)
	elif index == 2:
		$Sprite.texture = load(pathToTextureC)
	elif index == 3:
		$Sprite.texture = load(pathToTextureD)
