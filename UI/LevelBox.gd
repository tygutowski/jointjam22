extends PanelContainer

var level_num = 1 setget set_level

onready var label = $Label

func set_level(value):
	level_num = value
	label.text = "0" + str(level_num)

func _on_LevelBox_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		TimeManager.level_selected(level_num, true)
