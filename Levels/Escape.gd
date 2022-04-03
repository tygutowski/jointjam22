extends Area2D

func body_entered(body):
	if body.name == "Player":
		var next_level_num = int((get_node("/root").get_child(2).name).replace("Level","")) + 1
		TimeManager.level_selected(next_level_num)
