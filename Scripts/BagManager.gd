extends Node

var bag_list = []

onready var player = get_node("/root/Level1/Player")
onready var bag_scene = preload("res://Bag/BagPart.tscn")
onready var bag_parts = get_node("/root/Level1/BagParts")

func make_bag(size):
	for i in range(size):
		add_bag_segment(1)

func move_bags():
	var new_position = player.position
	for segment in bag_list:
		var tween = segment.get_node("Tween")
		var temp_position = segment.position
		tween.interpolate_property(segment, "position",
		segment.position, new_position, .1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		new_position = temp_position

func add_bag_segment(bag_type):
	print("adding bag segment of type: " + str(bag_type))
	var image_path 
	var new_bag = bag_scene.instance()
	if bag_type == 0:
		image_path = "res://Bag/front.png"
	elif bag_type == 1:
		image_path = "res://Bag/mid.png"
	elif bag_type == 2:
		image_path = "res://Bag/back.png"
	var image = Image.new()
	var texture = ImageTexture.new()
	var error = image.load(image_path)
	if error != OK:
		print('error')
	texture.create_from_image(image)
	new_bag.get_node("Sprite").texture = texture
	bag_list.append(new_bag)
	bag_parts.add_child(new_bag)
	
func do_turn():
	if is_instance_valid(player):
		move_bags()
