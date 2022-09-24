extends Area2D

export(int) var my_num = 1
var things_on_button = 0
func _ready():
	name = "Button" + str(my_num)

func body_entered(body):
	if body.name == "Player" or body.get_parent().get_parent().name == "BagParts":
		things_on_button += 1
		var door = get_node("../Door" + str(my_num))
		door.open()


func body_exited(body):
	if body.name == "Player" or body.get_parent().get_parent().name == "BagParts":
		things_on_button -= 1
		if things_on_button == 0:
			var door = get_node("../Door" + str(my_num))
			door.shut()
