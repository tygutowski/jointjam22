extends MarginContainer

func _ready():
	var music_player = load("res://MusicPlayer.tscn")
	var instanced_player = music_player.instance()
	get_node("/root").call_deferred("add_child", instanced_player)
