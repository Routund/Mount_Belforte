extends Node2D

var slime = preload("res://Scenes/slime.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var spawn_slime = slime.instantiate()
	spawn_slime.position = $".".get_global_position()
	get_tree().get_root().add_child(spawn_slime)
	await get_tree().create_timer(5).timeout
