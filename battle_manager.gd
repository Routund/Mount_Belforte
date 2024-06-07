extends Node2D

var player_health = 200
var enemy_health = 200

var deck = [0,1,2,3]
var hand = []
var queue = []
var card_funcs = [slash(),heal(),block(),run()]

@onready var HBox = get_node("Hand")

var card_preload = preload("res://card_instance.tscn")
var is_blocking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	draw()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (len(deck)>0):
		
		true
	pass

# All card functions
func slash():
	enemy_health-=70
func heal():
	# Make sure player doesnt overheal
	player_health=min(player_health+50,200)
func block():
	is_blocking=true
func run():
	return true

# Pick random card from deck, then add it to hand and remove from deck
# Then instantiate a new card with that ID
func draw():
	var chosen_index=randi_range(0,len(deck)-1)
	hand.append((deck[chosen_index]))
	deck.pop_at(chosen_index)
	var hand_last = hand[len(hand)-1]
	var instance = card_preload.instantiate()
	instance.set("card_id",hand_last)
	HBox.add_child(instance)
	
