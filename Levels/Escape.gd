extends Area2D

func body_entered(body):
	if body.name == "Player":
		var this_level_id = int((get_node("/root").get_child(3).name).replace("Level","")) 
		print(this_level_id)
		if get_node("../Pickups").get_child_count() != 0:
			TimeManager.level_selected(this_level_id)
			#get_tree().reload_current_scene()
		else:
			TimeManager.level_selected(this_level_id + 1)
