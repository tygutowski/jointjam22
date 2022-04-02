extends KinematicBody2D

<<<<<<< HEAD
onready var tween1 = get_node("Tween")
onready var tween2 = get_node("Tween2")
onready var ray = get_node("RayCast2D")
onready var bag_parts = get_node("../BagParts")
var tween_speed = 0.25

var velocity = Vector2.ZERO

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

func _ready():
	position = position.snapped(Vector2.ONE * tile_size) # set snapped position to the grid
	position.x += tile_size/2
	BagManager.make_bag(4)

func _process(_delta):
	direction = get_inputs() # direction is last input you pressed

func get_inputs():
	for dir in inputs.keys(): # for the possible cardinal inputs
		if Input.is_action_pressed(dir): # check them
			return dir # return your input as a string
	return "none" # otherwise if theres no WASD input, return none

func do_turn():
	direction = get_inputs() # get direction
	if can_move: # if allowed to move
		if direction == "none": # if you dont move
			return
		else: # if you do move
			ray.cast_to = inputs[direction] * tile_size # cast in the direction
			ray.force_raycast_update() # force update
			if !ray.is_colliding(): # if there is nothing in the cast direction
				move_tween(direction) # move using tween
				BagManager.do_turn()
			else:
				cannot_move_tween(direction)

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
=======
var size = 1
var size_max = 2
var size_min = .5

var speed = 100
var speed_mod = 1

var velocity = Vector2.ZERO

func _ready():
	pass

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_just_pressed("G"):
		scale_player(0.8)
	elif Input.is_action_just_pressed("H"):
		scale_player(1.2)
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = Vector2(horizontal, vertical)
	velocity = velocity.normalized() * speed * speed_mod

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func scale_player(value):
	size = max(size * value, size_min)
	scale = Vector2(size, size)

func scale_speed(value):
	speed_mod = speed_mod * value
>>>>>>> 53226496767c5f95a0715c775bcc07b8ba4c6073
