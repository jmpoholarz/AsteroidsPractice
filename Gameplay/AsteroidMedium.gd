extends Area2D

var smallAsteroid = load('res://Gameplay/AsteroidSmall.tscn')
var particleEmitter = load('res://Gameplay/AsteroidParticleEmitter.tscn')

var pathToTextureA = 'res://Assets/asteroid1a.png'
var pathToTextureB = 'res://Assets/asteroid1b.png'
var pathToTextureC = 'res://Assets/asteroid1c.png'
var pathToTextureD = 'res://Assets/asteroid1d.png'

signal increase_score(amount)

var velocity = Vector2(0,0)
var childSeed

func _ready():
	# Set node connections
	var mainNode = get_node("/root/Main/Screen/Play")
	connect("increase_score", mainNode, "increase_score")
	
	# Init random number generator
	randomize()
	# Set initial velocity
	velocity.x = randi() % 30 + 10
	velocity.y = randi() % 30 + 10
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

func _on_AsteroidMedium_area_shape_entered(area_id, area, area_shape, self_shape):
	# Play SFX
	SoundManager.playSFX(SoundManager.EXPLOSION)
	# Add small asteroids
	create_asteroids()
	# Create one-shot particle emitter
	var particles = particleEmitter.instance()
	particles.position = position
	particles.amount = 8
	get_parent().add_child(particles)
	# Increase score
	emit_signal("increase_score", 50)
	# Remove at the end of the grame
	queue_free()

func create_asteroids():
	# 10% chance of 4 asteroids
	if childSeed >= 90:
		var small4 = smallAsteroid.instance()
		small4.position = position
		get_parent().add_child(small4)
	# 20% chance of 3 asteroids
	if childSeed >= 70:
		var small3 = smallAsteroid.instance()
		small3.position = position
		get_parent().add_child(small3)
	# 50% chance of 2 asteroids
	if childSeed >= 20:
		var small2 = smallAsteroid.instance()
		small2.position = position
		get_parent().add_child(small2)
	# 20% chance of 1 asteroid
	if childSeed >= 0:
		var small1 = smallAsteroid.instance()
		small1.position = position
		get_parent().add_child(small1)


func load_graphic(index):
	if index == 0:
		$Sprite.texture = load(pathToTextureA)
	elif index == 1:
		$Sprite.texture = load(pathToTextureB)
	elif index == 2:
		$Sprite.texture = load(pathToTextureC)
	elif index == 3:
		$Sprite.texture = load(pathToTextureD)
