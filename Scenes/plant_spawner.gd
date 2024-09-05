extends Node2D

var slime = preload("res://Scenes/plant.gd")
# Called when the node enters the scene tree for the first time.

func _ready():
	if !Global.reset:
		if Global.slime==2:
			var spawn_slime = slime.new()
			add_child(spawn_slime)
			spawn_slime.position = $Spawn_point.position
			add_child(spawn_slime)
	else:
		Global.slime=1


func _on_timer_timeout():
	if Global.slime == 1:
		var spawn_slime = slime.new()
		spawn_slime.position = $Spawn_point.position
		add_child(spawn_slime)
