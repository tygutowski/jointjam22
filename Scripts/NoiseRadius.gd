extends Area2D

onready var player = get_node("../Player")
onready var collider = get_node("CollisionShape2D")

func _ready():
	collider.shape.extents.y = 50
	collider.shape.extents.x = 50

func _process(_delta):
	global_position = player.global_position

func scale_size(value):
	collider.shape.radius *= value
