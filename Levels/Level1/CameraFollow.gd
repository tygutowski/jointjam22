extends Camera2D

onready var player = get_node("../Player")

func _ready():
	current = true

func _process(_delta):
	pass
	#global_position = player.global_position
