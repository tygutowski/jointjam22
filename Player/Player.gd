extends KinematicBody2D
var size = 1
var size_mod = 0.1
var size_max = 2
var size_min = .1

var speed = 100
var speed_mod = 1

var velocity = Vector2.ZERO

func _ready():
	pass

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_just_pressed("G"):
		size *= 0.9
		scale = Vector2(size, size)
	elif Input.is_action_just_pressed("H"):
		size *= 1.1
		scale = Vector2(size, size)
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = Vector2(horizontal, vertical)
	velocity = velocity.normalized() * speed * speed_mod

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
