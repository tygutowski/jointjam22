extends Node

var bag_list = []

var player
var bag_scene
var bag_parts

func time_manager_ready(level_num, size):
	player = get_node("/root/Level" + str(level_num) + "/Player")
	bag_scene = load("res://Bag/BagPart.tscn")
	bag_parts = get_node("/root/Level" + str(level_num) + "/BagParts")
	bag_list.clear()
	make_bag(size)
	get_node("/root/Level" + str(level_num) + "/Camera2D").current = true

func make_bag(size):
	for _i in range(size):
		add_bag_segment()
	set_bag_textures()

func move_bags(dir, position):
	var new_position = position
	var new_rotation = 0
	if dir == "up":
		new_rotation = PI/2
	elif dir == "down":
		new_rotation = 3*PI/2
	elif dir == "left":
		new_rotation = 0
	elif dir == "right":
		new_rotation = PI

	for segment in bag_list:
		var temp_rotation = segment.get_node("Sprite").rotation
		segment.get_node("Sprite").rotation = new_rotation
		var tween = segment.get_node("Tween")
		var temp_position = segment.position
		tween.interpolate_property(segment, "position",
		segment.position, new_position, .25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		
		new_rotation = temp_rotation
		new_position = temp_position
func set_bag_textures():
	for bag in bag_list:
		if bag == bag_list[0]:
			bag.get_node("Sprite").texture = load("res://Bag/bag_front.tres")
		elif bag == bag_list[-1]:
			bag.get_node("Sprite").texture = load("res://Bag/bag_back.tres")
		else:
			bag.get_node("Sprite").texture = load("res://Bag/bag_mid.tres")
func add_bag_segment():
	var new_bag = bag_scene.instance()
	new_bag.get_node("Sprite").texture = load("res://Bag/bag_back.tres")
	if len(bag_list) != 0:
		new_bag.position = bag_list[-1].position
	else:
		new_bag.position = player.position
		new_bag.position.x -= 16
	bag_list.append(new_bag)
	bag_parts.call_deferred("add_child", new_bag)
	set_bag_textures()

func remove_bag_segment():
	if len(bag_list) >= 2:
		bag_list.remove(bag_list[-1])

func do_turn(direction, position):
	if is_instance_valid(player):
		move_bags(direction, position)
		bag_list[-1].get_node("Sprite").rotation = bag_list[-2].get_node("Sprite").rotation
