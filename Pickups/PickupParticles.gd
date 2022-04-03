extends AnimatedSprite

func _ready():
	playing = true
	visible = true

func animation_finished():
	queue_free()
