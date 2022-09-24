extends TextureRect

onready var credit_aa = load("res://Levels/Credits.tscn")
func _on_Button_pressed():
	queue_free()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if get_node_or_null("CREDIT") != null:
				get_node("CREDIT").queue_free()

func _on_credit_pressed():
	var new_credit = credit_aa.instance()
	new_credit.name = "CREDIT"
	add_child(new_credit)
