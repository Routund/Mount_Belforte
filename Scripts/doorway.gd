extends Area2D

var doorways = [
	["res://Scenes/Cave-1.tscn",[Vector2(1665,1838)]],
	["res://Scenes/cave_2.tscn", [Vector2(0,85),Vector2(19,738)]],
	["res://Scenes/cave_3.tscn", [Vector2(-984,-652),Vector2(173,1633)]],
	["res://Scenes/Forest-1.tscn", [Vector2(-260,-90),Vector2(486,-2015)]],
	["res://Scenes/forest_2.tscn", [Vector2(-65,25),Vector2(-67,-2015)]],
	["res://Scenes/forest_3.tscn", [Vector2(0,0),Vector2(-67,-2015)]]
]
var next_scene_data = [0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	next_scene_data[0] = int(self.name.split(" ")[0])
	next_scene_data[1] = int(self.name.split(" ")[1])
	pass # Replace with function body.


func _on_body_entered(body):
	if body.name == "Player":
		Global.state_dictionary["init_player_pos"]=doorways[next_scene_data[0]][1][next_scene_data[1]]
		# Changing is used by the battleWipe to determine wheter to go to a battle, or the next level
		Global.changing=true
		Global.reset=true
		Global.overworld_scene = doorways[next_scene_data[0]][0]
		get_parent().get_node("Player/WipeLayer").setDown()
		
