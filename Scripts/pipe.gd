extends Node2D
signal PlayerDie
signal PointAdd
var die = false

	
func _process(delta):
	if die == false :
		global_position.x -= 200 * delta
		if global_position.x < -100 :
			queue_free()


func _on_pipe_up_body_entered(body):
	if body.name == "Bird" :
		die = true
		global_position.x -= 0
		body.DC() #Die Condition
		emit_signal("PlayerDie")
		

func _on_pipe_down_body_entered(body):
	if body.name == "Bird" :
		die = true
		global_position.x -= 0
		body.DC() #Die Condition
		emit_signal("PlayerDie")


func _on_point_area_body_entered(_body):
	$Point_Area.queue_free()
	emit_signal("PointAdd")
