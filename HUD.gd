extends CanvasLayer

signal start_game

func update_level(value):
	var t = "Level: "
	if len(str(value)) == 1:
		t += "0" + str(value)
	else:
		t += str(value)
	$MarginContainer/LevelLabel.text = t

func update_score(value):
	var t = "Score: "
	var v_strlen = len(str(value))
	if v_strlen == 1:
		t += "00"
	elif v_strlen == 2:
		t += "0"
#	else:
#		print("HUD.update_score(): score > 100 !")
#		# nothing
	t += str(value)
	$MarginContainer/ScoreLabel.text = t

func update_time(value):
	var t = "Timer: "
	var v_strlen = len(str(value))
	if v_strlen == 1:
		t += "0" + str(value)
	else:
		t += str(value)
	$MarginContainer/TimeLabel.text = t

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$StartButton.show()


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")

func show_game_over():
	show_message("Game Over !!!")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "LIKE COINS!"
	$MessageLabel.show()
