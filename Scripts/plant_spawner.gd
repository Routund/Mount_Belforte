extends Node2D

var slime = preload("res://Scenes/plant.tscn")

func _ready():
	if !Global.reset:
		if Global.slime==2:
			var spawn_slime = slime.instantiate()
			add_child(spawn_slime)
			spawn_slime.position = $Spawn_point.position
			add_child(spawn_slime)
	else:
		Global.slime=1

func _process(delta):
	print(Global.slime)
	
	
func _on_timer_timeout():
	if Global.slime == 1:
		var spawn_slime = slime.instantiate()
		spawn_slime.position = $Spawn_point.position
		add_child(spawn_slime)
