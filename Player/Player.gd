extends KinematicBody2D

export(int) var bag_size
onready var tween1 = get_node("Tween")
onready var tween2 = get_node("Tween2")
onready var ray = get_node("RayCast2D")
onready var bag_parts = get_node("../BagParts")
var tween_speed = 0.25
var turn_direction = "none"
var velocity = Vector2.ZERO
var former_direction
var tile_size = 16
var can_move = true
var direction = "none"
var bounce_back = false
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}
var current_level_num = 1
func time_manager_ready(level_num):
	current_level_num = level_num
	position = position.snapped(Vector2.ONE * tile_size) # set snapped position to the grid
	position.x += tile_size/2
	position.y += tile_size/2
	BagManager.time_manager_ready(level_num, bag_size)

func _process(_delta):
	direction = get_inputs() # direction is last input you pressed
func get_inputs():
	if Input.is_action_just_pressed("menu"):
		var err = get_tree().change_scene("res://Levels/Menu.tscn")
		if err != OK:
			print(err)
	if Input.is_action_just_pressed("r"):
		TimeManager.level_selected(current_level_num, true)
	for dir in inputs.keys(): # for the possible cardinal inputs
		if Input.is_action_pressed(dir): # check them
			return dir # return your input as a string
	return "none" # otherwise if theres no WASD input, return none

func do_turn():
	if can_move: # if allowed to move
		turn_direction = get_inputs() # get direction
		if turn_direction == "none": # if you dont move
			return
		else: # if you do move
			$AnimationPlayer.play(turn_direction)
			
			ray.cast_to = inputs[turn_direction] * tile_size # cast in the direction
			ray.force_raycast_update() # force update
			if ray.is_colliding(): # if there is nothing in the cast direction
				cannot_move_tween(turn_direction)
			else:
				move_tween(turn_direction) # move using tween
				BagManager.do_turn(former_direction, position)
				former_direction = turn_direction
func move_tween(dir): # tween position between tiles
	tween1.interpolate_property(self, "position", # change position
	position, position + inputs[dir] * tile_size, # from position, to new position
	TimeManager.seconds_per_turn/2, Tween.TRANS_SINE, Tween.EASE_IN_OUT) # using speed, ease in/out
	can_move = false # you cannot move when tweening
	tween1.start() # start tween

func cannot_move_tween(dir):
	var initial_pos = position
	tween1.interpolate_property(self, "position", # change position
	position, position + inputs[dir] * tile_size/8, # from position, to new position
	TimeManager.seconds_per_turn/4, Tween.TRANS_SINE, Tween.EASE_IN_OUT) # using speed, ease in/out
	can_move = false # you cannot move when tweening
	tween1.start() # start tween
	get_node("bump_sfx").playing = true
	tween2.interpolate_property(self, "position", # change position
	position, initial_pos, # from position, to new position
	TimeManager.seconds_per_turn/2, Tween.TRANS_SINE, Tween.EASE_IN_OUT) # using speed, ease in/out
	
func tween_completed(_object, _key): # WHEN YOU FINISH MOVING, YOU CAN MOVE AGAIN
	can_move = true
	tween2.start()
