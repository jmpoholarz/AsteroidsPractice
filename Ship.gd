extends RigidBody2D

var MAX_SPEED = 250
var BULLET_MAG = 250
var rotation_angle

var Bullet = load("res://Bullet.tscn")

func _ready():
	position.x = 200
	position.y = 200
	rotation_angle = rotation_degrees
	pass

func _process(delta):
	# Handle rotation
	if Input.is_action_pressed('ship_rotate_left') && \
		!Input.is_action_pressed('ship_rotate_right'):
			rotation_angle -= 400 * delta
			$Sprite.rotation_degrees -= 400 * delta
	elif Input.is_action_pressed('ship_rotate_right') && \
		!Input.is_action_pressed("ship_rotate_left"):
			rotation_angle += 400 * delta
			$Sprite.rotation_degrees += 400 * delta
	# Shoot bullet if cooldown over
	if Input.is_action_just_pressed('ship_shoot') && $ShootDelay.is_stopped():
		$ShootDelay.start()
		# Create the bullet
		var bullet = Bullet.instance()
		# Set direction 
		var ship_u_vec = Vector2(sin(rotation_angle*PI/180), -cos(rotation_angle*PI/180))
		var mag = magnitude(linear_velocity.x, linear_velocity.y)
		# If the ship is moving, account for it in the bullet velocity calculation
		if mag > 0:
			bullet.linear_velocity.x = ship_u_vec.x * BULLET_MAG + linear_velocity.x
			bullet.linear_velocity.y = ship_u_vec.y * BULLET_MAG + linear_velocity.y
		# Otherwise use just the bullet magnitude to calculate
		else:
			bullet.linear_velocity.x = ship_u_vec.x * BULLET_MAG
			bullet.linear_velocity.y = ship_u_vec.y * BULLET_MAG
		add_child(bullet)
		
	pass

func _integrate_forces(state):
	# Handle forward movement
	if Input.is_action_pressed('ship_go_forward'):
		var d = 2*Vector2(sin(rotation_angle*PI/180), -cos(rotation_angle*PI/180))
		print(d)
		linear_velocity += d
	# Limit to max speed if over it
	var mag = magnitude(linear_velocity.x, linear_velocity.y)
	if mag > MAX_SPEED:
		linear_velocity.x = linear_velocity.x / mag * MAX_SPEED
		linear_velocity.y = linear_velocity.y / mag * MAX_SPEED

func magnitude(x_vel, y_vel):
	return sqrt(x_vel * x_vel + y_vel * y_vel)