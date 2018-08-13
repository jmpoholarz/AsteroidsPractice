extends Area2D

var Bullet = load("res://Bullet.tscn")
var Explosion = load("res://Explosion.tscn")

var MAX_SPEED = 250
var BULLET_MAG = 250
var velocity = Vector2(0,0)
var rotation_angle
var isDead
var isInvincible


func _ready():
	isDead = false
	isInvincible = false
	position.x = 200
	position.y = 200
	rotation_angle = rotation_degrees
	pass


func _process(delta):
	# Ignore input if dead
	if isDead == true:
		return
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
		var mag = magnitude(velocity.x, velocity.y)
		# If the ship is moving, account for it in the bullet velocity calculation
		if mag > 0:
			print(str(ship_u_vec.x) + "*" + str(BULLET_MAG) + "+" + str(velocity.x))
			#bullet.velocity.x = ship_u_vec.x * BULLET_MAG + velocity.x
			print(str(ship_u_vec.y) + "*" + str(BULLET_MAG) + "+" + str(velocity.y))
			#bullet.velocity.y = ship_u_vec.y * BULLET_MAG + velocity.y
		# Otherwise use just the bullet magnitude to calculate
		else:
			bullet.velocity.x = ship_u_vec.x * BULLET_MAG
			bullet.velocity.y = ship_u_vec.y * BULLET_MAG
		add_child(bullet)
		
	pass


func _physics_process(delta):
	if isDead == true:
		return
	# Handle forward movement
	if Input.is_action_pressed('ship_go_forward'):
		var d = 2*Vector2(sin(rotation_angle*PI/180), -cos(rotation_angle*PI/180))
		velocity += d
	# Limit to max speed if over it
	var mag = magnitude(velocity.x, velocity.y)
	if mag > MAX_SPEED:
		velocity.x = velocity.x / mag * MAX_SPEED
		velocity.y = velocity.y / mag * MAX_SPEED
	# Update position
	position.x += velocity.x * delta
	position.y += velocity.y * delta


func magnitude(x_vel, y_vel):
	return sqrt(x_vel * x_vel + y_vel * y_vel)


func _on_Ship_area_shape_entered(area_id, area, area_shape, self_shape):
	# Ignore simultaneous deaths
	if isDead || isInvincible:
		return
	# Ship crash
	isDead = true
	# Hide ship and stop moving
	velocity = Vector2(0,0)
	$Sprite.visible = false
	# Play explosion graphic
	add_child(Explosion.instance())
	# Wait for respawn
	$RespawnDelay.start()


func _on_RespawnDelay_timeout():
	isDead = false
	isInvincible = true
	$Sprite.visible = true
	$Sprite/AnimationPlayer.play("Invincible")



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Invincible":
		isInvincible = false;