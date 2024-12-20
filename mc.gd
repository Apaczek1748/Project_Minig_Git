extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var current_level:Node2D

#jump count
var jump_count = 0
var max_jump = 2


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	# Add the gravity. 
	if not is_on_floor() and not Input.is_action_pressed("grav"):
		velocity += get_gravity() * delta
		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D.animation = "jump"
		
	if Input.is_action_pressed("grav"):
			velocity += -get_gravity() * delta * 0.5
			$AnimatedSprite2D.animation = "grav"
			
	# Handle jump.
	if is_on_floor():
		jump_count = 0
		
	if Input.is_action_just_pressed("jump") and jump_count<max_jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		if is_on_floor():
			$AnimatedSprite2D.flip_h = direction < 0
			$AnimatedSprite2D.animation = "run"
		else:
			if not Input.is_action_pressed("grav"):
				$AnimatedSprite2D.animation = "jump"
		velocity.x = direction * SPEED
	else:
		$AnimatedSprite2D.animation = "idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("gem"):
		current_level.update_ui_score(body.value)
		body.collect()
		
