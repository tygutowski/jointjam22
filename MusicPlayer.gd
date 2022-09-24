extends AudioStreamPlayer

func _ready():
	var sfx = load("res://intro.mp3")
	sfx.loop = false
	stream = sfx

func _process(_delta):
	if len(get_tree().get_nodes_in_group("Level")) != 0:
		if !playing:
			play()
	else:
		if playing:
			stop()

func _on_AudioStreamPlayer_finished():
	var sfx = load("res://loop.mp3")
	sfx.loop = true
	stream = sfx
	play()
