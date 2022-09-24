extends StaticBody2D
export(int) var my_num = 1
var things_on_door = 0
var cannot_shut = false
func _ready():
	name = "AntiDoor" + str(my_num)
	open()

func _process(_delta):
	if cannot_shut:
		shut()

func shut():
	if things_on_door == 0:
		get_node("CollisionShape2D").set_deferred("disabled", false)
		get_node("Sprite").visible = true
		cannot_shut = false
	else:
		cannot_shut = true

func open():
	get_node("CollisionShape2D").set_deferred("disabled", true)
	get_node("Sprite").visible = false

func body_exited(body):
	if body.name == "Player" or body.get_parent().get_parent().name == "BagParts":
		things_on_door -= 1

func body_entered(body):
	if body.name == "Player" or body.get_parent().get_parent().name == "BagParts":
		things_on_door += 1
