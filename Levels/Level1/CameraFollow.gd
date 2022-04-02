extends Camera2D

onready var player = get_node("../Player")

func _ready():
	current = true

func _process(_delta):
<<<<<<< HEAD
	global_position = player.global_position
=======
	pass
	#global_position = player.global_position
>>>>>>> 53226496767c5f95a0715c775bcc07b8ba4c6073
