extends CanvasLayer

var scene = ["res://Scenes/Cave-1.tscn",
			"res://Scenes/cave_2.tscn",
			"res://Scenes/cave_3.tscn",
			"res://Scenes/Forest-1.tscn",
			"res://Scenes/forest_2.tscn",
			"res://Scenes/forest_3.tscn"]


func _on_start_pressed():
	print(Global.level, "a")
	get_tree().change_scene_to_file(scene[Global.level])


func _on_button_pressed():
	get_tree().change_scene_to_file(scene[Global.level])
