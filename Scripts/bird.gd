extends CharacterBody2D
@export var G = 1000 #gravity
@export var JF = 18000 #JumpForce
var started = false
var alive = true
var one_time = true
signal Fall
func _physics_process(delta):
	if alive == true :
		if Input.is_action_just_pressed("Flap") :
			started = true
			print(global_position)
			if global_position.y <= 40 :
				pass
			else :
				velocity.y = -JF * delta
		
	if started == true :
		$AnimationPlayer.stop()
		if !is_on_floor() :
			velocity.y += G * delta
			if velocity.y < 0 :
				global_rotation_degrees -= 2
				if global_rotation_degrees <= -20 :
					global_rotation_degrees = -20
					global_rotation_degrees -= 0
			elif velocity.y > 0 :
				global_rotation_degrees += 2
				if global_rotation_degrees >= 20:
					global_rotation_degrees = 20
					global_rotation_degrees += 0
			elif velocity.y == 0 :
				global_rotation_degrees = 0
		if is_on_floor() :
			emit_signal("Fall")
			FC()
	move_and_slide()
	
func DC() :
	alive = false
	if one_time == true :
		one_time = false
		velocity.y = -500
		$Hit.play()
	$AnimatedSprite2D.stop()

func FC() :
	alive = false
	if one_time == true :
		one_time = false
		$Hit.play()
	$AnimatedSprite2D.stop()

	
	
