extends Node2D

var player_health = 200
var enemy_health = 200

var deck = [0,1,2,3]
var hand = []
var queue = []
var card_funcs = [slash(),heal(),block(),run()]


var is_blocking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
func draw():
	var chosen_index=randi_range(0,len(deck))
	hand.append((deck[chosen_index]))
	deck.pop_at(chosen_index)
	
