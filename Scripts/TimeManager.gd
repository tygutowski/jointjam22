extends Node

var seconds_per_turn = .5
var current_time = 0
onready var player = get_node("/root/Level1/Player")
onready var progress = get_node("/root/Level1/CanvasLayer/TextureProgress")
onready var tween = get_tree().get_root().get_node("Level1/CanvasLayer/Tween")
onready var bag_parts = get_node("/root/Level1/BagParts")
func _ready():
	if is_instance_valid(player) and is_instance_valid(bag_parts):
		current_time = 0
		tween.interpolate_property(progress, "value",
		0, 100, seconds_per_turn, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
		tween.start()
		player.do_turn()

func _physics_process(delta):
	if is_instance_valid(player) and is_instance_valid(bag_parts):
		current_time += delta
		if current_time > seconds_per_turn:
			current_time -= seconds_per_turn
			player.do_turn()
			tween.interpolate_property(progress, "value",
			0, 100, seconds_per_turn, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
			tween.start()
