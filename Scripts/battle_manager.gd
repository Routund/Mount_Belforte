extends Node2D

var player_health = 200
var player_max = 200
var enemy_health = 200
var enemy_max = 200
var enemy_id = 0

var deck = [0,1,2,3]
var hand = []
var queue = []
var card_funcs = [slash,heal,block,run]

@onready var HBox = get_node("Hand")
@onready var PlayerHealthBar = get_node("../../Player/PlayerHealthBar")
@onready var EnemyHealthBar = get_node("../../Enemy/EnemyHealthBar")

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

func damage_enemy(amount):
	enemy_health-=amount
	EnemyHealthBar.TweenTo(enemy_health,enemy_max)
# All player card functions
func slash():
	damage_enemy(70)
func heal():
	# Make sure player doesnt overheal
	damage_player(-min(40,player_max-player_health))
func block():
	is_blocking=true
func run():
	get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")
	return true

func damage_player(amount):
	if(is_blocking):
		amount/=4
	player_health-=amount
	PlayerHealthBar.TweenTo(player_health,player_max)
# All enemy attack functions
func basic_attack():
	damage_player(40)

# Pick random card from deck, then add it to hand and remove from deck
# Then instantiate a new card with that ID
func draw():
	var chosen_index=randi_range(0,len(deck)-1)
	hand.append((deck[chosen_index]))
	deck.pop_at(chosen_index)
	var hand_last = hand[len(hand)-1]
	var instance = card_preload.instantiate()
	instance.set("card_id",hand_last)
	get_node("Control").add_child(instance)

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
	is_blocking=false
	print("Enemy Health: " + str(enemy_health))
	print("Player Health: " + str(player_health))
	pass # Replace with function body.
