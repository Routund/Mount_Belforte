extends Node
#0 is slash attack 
#1 is heal
#2 is block
#3 is poison 
#4 is run
#5 is water botttle
var inventory = [0,1,2,4] 

var deck = [0,1,2,4]
signal battleStarting


var enemy_id = 0
var reset = true
var inventory_open = false
var slime = 1
var state_dictionary = {}
var overworld_scene = "res://Scenes/Overworld.tscn"

func battle(id):
	battleStarting.emit()
	enemy_id=id
	overworld_scene = get_tree().current_scene.scene_file_path
