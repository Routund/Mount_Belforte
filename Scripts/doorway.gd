extends Area2D

var doorways = [
	["res://Scenes/Cave-1.tscn",[Vector2(1665,1838)]],
	["res://Scenes/cave_2.tscn", [Vector2(0,0)]]
]
var next_scene_data = [0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	next_scene_data[0] = int(self.name.split(" ")[0])
	next_scene_data[1] = int(self.name.split(" ")[1])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.name == "Player":
		Global.state_dictionary["init_player_pos"]=doorways[next_scene_data[0]][1][next_scene_data[1]]
		get_tree().change_scene_to_file(doorways[next_scene_data[0]][0])
