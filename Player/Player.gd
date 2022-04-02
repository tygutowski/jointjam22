extends KinematicBody2D

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
