extends GridContainer

func _ready():
	for level in get_children():
		if(level.get_index() < 10):
			level.set_locked(false)
		level.set_level(level.get_index() + 1)

