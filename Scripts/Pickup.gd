extends Node2D

export(String, "None", "Large", "Small") var type
export(Texture) var text

func _ready():
	if text != null:
		get_node("Sprite").texture = text

func body_entered(body):
	if body.name == "Player":
		pick_item()
		empower_player(body)
		get_node("/root/Level1/AudioStreamPlayer").playing = true
		var particle = load("res://Pickups/PickupParticles.tscn")
		var new_particle = particle.instance()
		get_node("/root/Level1/Particles").add_child(new_particle)
		new_particle.position = position
		queue_free()

func pick_item():
	pass

func empower_player(body):
	match type:
		"Large":
			increase_bag_size()
		"Small":
			decrease_bag_size()

func increase_bag_size():
	BagManager.add_bag_segment()

func decrease_bag_size():
	BagManager.remove_bag_segment()


func particle_animation_finished():
	get_node("AnimatedSprite").queue_free()
