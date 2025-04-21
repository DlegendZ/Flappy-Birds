extends Node2D
var TimerOn = false
var Score = 0
var HighScore
signal Stop_Moving
func _ready():
	openhs()
func savehs() :
	var writehs = FileAccess.open("user://HighScoreFlappy", FileAccess.WRITE)
	writehs.store_32(HighScore)
func openhs() :
	var readhs = FileAccess.open("user://HighScoreFlappy", FileAccess.READ)
	if readhs != null :
		HighScore = readhs.get_32()
		$UI.UpdateHS(HighScore)
	else : 
		HighScore = 0
func _process(_delta):
	if Input.is_action_just_pressed("Flap") :
		$Audio/Wing.play()
		if TimerOn == false :
			get_node("Pipe Spawner/Timer").start()
			get_node("Ground/AnimationPlayer").play("Ground Looping")
			get_node("UI/Score").text = str(Score)
			get_node("UI/Sprite2D").visible = false
			get_node("UI/AnimationPlayer").stop()
			$UI.UpdateScore(Score)
			$UI.UpdateHS(HighScore)
			TimerOn = true 
	if Input.is_action_just_pressed("Restart") :
		get_tree().reload_current_scene()

func WhenPlayerDie() :
	get_node("Ground/AnimationPlayer").pause()
	get_node("Pipe Spawner/Timer").stop()
	get_node("UI/GameOver").visible = true
	$Audio/Wing.stream = null
	var PipeList = get_node("Pipe Spawner/Pipe Container").get_children()
	for Pipe in PipeList :
		Pipe.die = true
	UpdateHighScore()

func UpdateHighScore() :
	if Score > HighScore :
		HighScore = Score
		$UI.UpdateHS(HighScore)
		savehs()

func GetPoint() :
	Score += 1
	$UI.UpdateScore(Score)
	$Audio/Point.play()

func _on_pipe_spawner_pipe(PipeId):
	get_node("Pipe Spawner/Pipe Container").add_child(PipeId)
	PipeId.connect("PlayerDie", WhenPlayerDie)
	PipeId.connect("PointAdd", GetPoint)
	
func _on_bird_fall():
	get_node("Ground/AnimationPlayer").pause()
	get_node("Pipe Spawner/Timer").stop()
	get_node("UI/GameOver").visible = true
	$Audio/Wing.stream = null
	var PipeList = get_node("Pipe Spawner/Pipe Container").get_children()
	for Pipe in PipeList :
		Pipe.die = true
	UpdateHighScore()
