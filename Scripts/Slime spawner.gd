extends CharacterBody2D

var slime = preload("res://Scenes/slime.tscn")
# Called when the node enters the scene tree for the first time.


func _on_spawn_time_timeout():
	if Global.slime == 1:
		var spawn_slime = slime.instantiate()
		spawn_slime.position = $Spawn_point.position
		add_child(spawn_slime)
