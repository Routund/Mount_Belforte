extends Node2D

var player_health = 200
var player_max = 200
var enemy_health = 200
var enemy_max = 200
var enemy_id = 0
var i = 0

var deck = [0,1,2,3]
var hand = []
var queue = []
var card_funcs = [slash,heal,block,poison,run]
const card_descs = ["Slash Attack","Heal","Block","Poison Enemy","Run away"]

var go_next =false
var edamaged = false
var pdamaged = false
var enemyAttacked=true

@onready var HBox = get_node("Hand")
@onready var PlayerHealthBar = get_node("../../PlayerHealthBar")
@onready var EnemyHealthBar = get_node("../../EnemyHealthBar")
@onready var EnemyAnimator = get_node("../../Enemy")
@onready var PlayerAnimator = get_node("../../Player")

var card_preload = preload("res://Scenes/card_instance.tscn")
var is_blocking = false
var poisoned = false
var poisonDamageDone = true
# Called when the node enters the scene tree for the first time.
func _ready():
	deck = Global.deck.duplicate()
	draw()
	draw()
	enemy_id=Global.enemy_id
	EnemyAnimator.enemy_id=enemy_id
	EnemyAnimator.load_frames()
	enemy_health=enemies[enemy_id][1]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(go_next):
		go_next=false
		if(i<len(queue)):
			edamaged = false
			card_funcs[queue[i]].call()
			deck.append(queue[i])
			i+=1
		elif(queue!=[]):
			queue = []
			if(enemy_health<=0):
				Global.reset=false
				get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")
				return true
			go_next = true
		elif(!enemyAttacked):
			enemyAttacked=true
			pdamaged= false
			enemies[enemy_id][3][randi_range(0,len(enemies[enemy_id][3])-1)].call()
		else:
			if !poisonDamageDone:
				poisonDamageDone=true
				damage_enemy(20,false)
			else:
				draw()
				is_blocking=false
				$Button.disabled=false
				print("Enemy Health: " + str(enemy_health))
				print("Player Health: " + str(player_health))
				if player_health <= 0:
					Global.reset=true
					get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")
					return true
				elif enemy_health <= 0:
					Global.reset=false
					get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")
					return true
			


func damage_enemy(amount,animated):
	enemy_health-=amount
	if(animated):
		PlayerAnimator.play("attack")
		edamaged=true
	else:
		EnemyAnimator.play("hurt")
		EnemyHealthBar.TweenTo(enemy_health,enemy_max)
		
# All player card functions
func slash():
	damage_enemy(60,true)
func heal():
	# Make sure player doesnt overheal
	damage_player(-min(40,player_max-player_health))
func block():
	is_blocking=true
	go_next=true
func poison():
	EnemyHealthBar.Health_Rect.modulate = Color8(142,52,154)
	poisoned=true
	poisonDamageDone=false
	go_next=true
func run():
	Global.reset=true
	get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")
	return true

func damage_player(amount):
	if(amount<0):
		player_health-=amount
		PlayerHealthBar.TweenTo(player_health,player_max)
	else:
		if(is_blocking):
			amount/=4
		player_health-=amount
		EnemyAnimator.play("attack")
		pdamaged=true
# All enemy attack functions
func basic_attack():
	damage_player(50)

# Pick random card from deck, then add it to hand and remove from deck
# Then instantiate a new card with that ID
func draw():
	if(len(deck)>0):
		var chosen_index=randi_range(0,len(deck)-1)
		hand.append((deck[chosen_index]))
		deck.pop_at(chosen_index)
		var hand_last = hand[len(hand)-1]
		var instance = card_preload.instantiate()
		instance.set("card_id",hand_last)
		instance.set("text_to_set",card_descs[hand_last])
		get_node("Control").add_child(instance)

func queue_card(card):
	hand.pop_at(hand.find(card))
	queue.append(card)
	if len(queue)==1:
		$Button.text=='Play cards'

func dequeue_card(card):
	queue.pop_at(queue.find(card))
	hand.append(card)
	if len(queue)==0:
		$Button.text=='Skip Turn'

var enemies = [["Slime",150,1,[basic_attack]],["Rock bat",150,1,[basic_attack]]]

func _on_button_confirm_play():
	enemyAttacked=false
	go_next=true
	i=0
	if poisoned:
		poisonDamageDone=false
	pass # Replace with function body.


func _on_enemy_animation_finished():
	if pdamaged:
		PlayerAnimator.play("hurt")
		PlayerHealthBar.TweenTo(player_health,player_max)
		pdamaged=false
	pass # Replace with function body.

func _on_player_animation_finished():
	if edamaged:
		EnemyAnimator.play("hurt")
		EnemyHealthBar.TweenTo(enemy_health,enemy_max)
		edamaged=false
	pass # Replace with function body.

func _on_player_health_bar_player_health_bar_finished():
	go_next=true
	pass # Replace with function body.


func _on_enemy_health_bar_enemy_health_bar_finished():
	go_next=true
	pass # Replace with function body.
