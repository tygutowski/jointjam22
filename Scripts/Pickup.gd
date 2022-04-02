extends Node2D

export(String, "None", "Large", "Small", "Loud", "Quiet", "Slow", "Fast") var type

func body_entered(body):
	if body.name == "Player":
		empower_player(body)
		queue_free()

func empower_player(body):
	
	match type:
		"Large":
			body.scale_player(1.2)
		"Small":
			body.scale_player(0.8)
		"Loud":
			pass
			#noise_indicator.scale_size(1.2)
		"Quiet":
			pass
			#noise_indicator.scale_size(0.8)
		"Slow":
			body.scale_speed(0.8)
		"Fast":
			body.scale_speed(1.2)
