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
var battle_start_timer = Timer.new()


var enmemy_id = 0
var reset = true
var inventory_open = false
var slime = 1

var state_dictionary = {}

func battle(id):
	battleStarting.emit()
	battle_start_timer.connect("timeout",change_to_battle)
	battle_start_timer.wait_time=0.1
	battle_start_timer.one_shot=true
	battle_start_timer.start()
	enmemy_id=id
	
func change_to_battle():
	get_tree().change_scene_to_file("res://Scenes/Battle.tscn")
	
