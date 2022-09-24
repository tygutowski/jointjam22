extends Area2D

func body_entered(body):
	var this_level_id = 0
	if body.name == "Player":
		for level in get_tree().get_nodes_in_group("Level"):
			if "Level" in level.name:	
				this_level_id = int(level.name.replace("Level","")) 
		if get_node("../Pickups").get_child_count() == 0:
			if(this_level_id + 1 == 6):
				get_tree().change_scene("res://Levels/Menu.tscn")
			else:
				TimeManager.level_selected(this_level_id + 1, true)
		else:
			TimeManager.level_selected(this_level_id, false)
