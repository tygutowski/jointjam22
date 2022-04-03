extends Node

var seconds_per_turn = .5
var current_time = 0
var current_level = 0
var loaded = false
var player
var progress
var tween
var bag_parts
var tilemap

func level_selected(level_num):
	get_tree().change_scene("res://Levels/Level" + str(level_num) + "/Level" + str(level_num) + ".tscn")
	yield(get_tree().create_timer(0.5), "timeout")
	current_level = level_num
	player = get_node("/root/Level" + str(current_level) + "/Player")
	progress = get_node("/root/Level" + str(current_level) + "/CanvasLayer/TextureProgress")
	tween = get_tree().get_root().get_node("Level" + str(current_level) + "/CanvasLayer/Tween")
	bag_parts = get_node("/root/Level" + str(current_level) + "/BagParts")
	tilemap = get_node("/root/Level" + str(current_level) + "/Tilemap")
	loaded = true
	player.time_manager_ready(level_num)
	print("read")
func _physics_process(delta):
	if loaded:
		if is_instance_valid(player) and is_instance_valid(bag_parts):
			current_time += delta
			if current_time > seconds_per_turn:
				current_time -= seconds_per_turn
				player.do_turn()
				tween.interpolate_property(progress, "value",
				0, 100, seconds_per_turn, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
				tween.start()
