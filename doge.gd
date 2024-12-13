extends CharacterBody2D


var SPEED = 100
const JUMP_VELOCITY = -400.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		velocity.x = 100
		$AnimatedSprite2D.animation = "idle_doge"
		
	else:
		velocity += get_gravity() * delta
		$AnimatedSprite2D.animation = "fall_doge"
	move_and_slide()
	
