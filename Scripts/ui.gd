extends Control
func UpdateScore(NewScore) :
	$Score.text = str(NewScore)
	get_node("GameOver/Panel/Score").text = "SCORE : " + str(NewScore)
func UpdateHS(NewHS) :
	get_node("GameOver/Panel/HighScore").text = "HIGHSCORE : " + str(NewHS)
