extends CharacterBody2D

@export var speed = 500
var jump_velocity_medium = -700
var jump_velocity_high = -900
var gravity = 1200

# Dash properties
@export var dash_speed = 2000  
@export var dash_duration = 0.15
@export var dash_cooldown = 0.5
var can_dash = true
 # Fixed typo
var jump_sequence = []
var dash_timer: Timer
var is_dashing = false

func _ready() -> void:
	dash_timer = Timer.new()
	dash_timer.one_shot = true
	add_child(dash_timer)

func _physics_process(delta: float) -> void:
	# Handle movement
	if is_dashing:
		velocity.x = dash_speed  # Apply dash speed
	else:
		velocity.x = speed  # Normal movement

	# Handle jumping
	if Input.is_action_just_pressed("jump_medium") and is_on_floor():
		velocity.y = jump_velocity_medium
		jump_sequence.append("medium")
	if Input.is_action_pressed("jump_high") and is_on_floor():
		velocity.y = jump_velocity_high
		jump_sequence.append("high")
	
	# Apply gravity (only when not dashing)
	if !is_dashing:
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 2000)
	
	move_and_slide()

	# Dash input - available anytime
	if Input.is_action_just_pressed("jump_low") and can_dash:
		start_dash()
		jump_sequence.append("low")
		# Returns the number of times the player collided in the last call
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("hazards"):
			kill_player()

func start_dash():
	can_dash = false
	is_dashing = true
	
	# Freeze vertical movement during dash
	velocity.y = 0
	
	dash_timer.wait_time = dash_duration
	dash_timer.start()
	await dash_timer.timeout
	
	is_dashing = false
	
	dash_timer.wait_time = dash_cooldown
	dash_timer.start()
	await dash_timer.timeout
	
	can_dash = true

func get_jump_sequence():
	return jump_sequence

func kill_player():
	GameManager.player_dead = true
	queue_free()	
