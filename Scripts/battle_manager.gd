extends Node2D

var player_health = 200
var enemy_health = 200
var enemy_id = 0

var deck = [0,1,2,3]
var hand = []
var queue = []
var card_funcs = [slash,heal,block,run]

@onready var HBox = get_node("Hand")

var card_preload = preload("res://Scenes/card_instance.tscn")
var is_blocking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	draw()
	draw()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (len(deck)>0):
		true
	pass

# All player card functions
func slash():
	enemy_health-=70
func heal():
	# Make sure player doesnt overheal
	player_health=min(player_health+40,200)
func block():
	is_blocking=true
func run():
	return true

# All enemy attack functions
func basic_attack():
	player_health-=40


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

func queue_card(card):
	hand.pop_at(hand.find(card))
	queue.append(card)

func dequeue_card(card):
	queue.pop_at(queue.find(card))
	hand.append(card)

var enemies = [["Slime",150,1,[basic_attack]]]

func _on_button_confirm_play():
	for card in queue:
		card_funcs[card].call()
		deck.append(card)
	queue = []
	print(len(enemies[enemy_id][3]))
	enemies[enemy_id][3][randi_range(0,len(enemies[enemy_id][3])-1)].call()
	if(len(deck)>0):
		draw()
	print("Enemy Health: " + str(enemy_health))
	print("Player Health: " + str(player_health))
	pass # Replace with function body.
