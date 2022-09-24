extends AStar_Path

onready var player = get_node("../Player")
onready var enemies = get_node("../Enemies")


func do_turn():
	if is_instance_valid(enemies):
		for enemy in enemies.get_children():
			_get_path(world_to_map(enemy.global_position), world_to_map(player.global_position))
			move(enemy)
func move(target):
	return
	if len(path) != 0:
		if len(path) <= 5:
			var original_position = target.global_position
			var new_position = map_to_world(path[0])
			new_position = new_position.snapped(Vector2.ONE * 16) # set snapped position to the grid
			new_position.x += 16/2
			
			var tween = target.get_node("Tween")
			tween.interpolate_property(target, "global_position", # change position
			original_position, new_position, # from position, to new position
			TimeManager.seconds_per_turn/2, Tween.TRANS_SINE, Tween.EASE_IN_OUT) # using speed, ease in/out
			tween.start() # start tween
			
