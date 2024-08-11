extends Node2D

var slime = preload("res://Scenes/slime.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	if !Global.reset:
		if Global.slime==2:
			var spawn_slime = slime.instantiate()
			add_child(spawn_slime)
			spawn_slime.position = Global.state_dictionary["slime_pos"]
		elif "water" in Global.state_dictionary.keys():
			var spawn_slime = slime.instantiate()
			spawn_slime.death=true
			spawn_slime.water_card=true
			spawn_slime.position = Global.state_dictionary["slime_pos"]
			add_child(spawn_slime)
			
	else:
		Global.slime=1

func _on_spawn_time_timeout():
	if Global.slime == 1:
		var spawn_slime = slime.instantiate()
		spawn_slime.position = $Spawn_point.position
		add_child(spawn_slime)
