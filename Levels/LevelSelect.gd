extends GridContainer

func _ready():
	for level in get_children():
		level.set_level(level.get_index() + 1)

