extends Node2D
signal Pipe(PipeId)
func _on_timer_timeout():
	SpawnPipe()

func SpawnPipe() :
	var Pipe = preload("res://Scenes/pipe.tscn")
	var PipeIntance =  Pipe.instantiate()
	PipeIntance.global_position = Vector2(350,randf_range(400,512))
	emit_signal("Pipe", PipeIntance)

