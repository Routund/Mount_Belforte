extends Node2D

var player_health = 200
var player_max = 200
var enemy_health = 200
var enemy_max = 1000
var enemy_id = 0
var i = 0

var deck = [0,1,2,3]
var hand = []
var queue = []
var card_funcs = [slash,heal,block,poison,run,water,recoil]
const card_descs = ["Slash Attack","Heal","Block","Poison Enemy","Run away","Vial of water","Headbutt"]
var enemies = [
	["Slime",120,1,[slimeai],true],
	["Rock bat",0,1,[batai],false],
	["Golem",280,1,[golemAi],false],
	["Cat", 160,1,[catAi], true]
	]

var go_next =false
var edamaged = false
var pdamaged = false
var enemyAttacked=true
var continuable=false
var runFlag = false
var winFlag = false
var loseFlag = false
var recoilFlag = false
var is_blocking = false
var enemy_blocking = false
var enemy_charging = false
var enemy_charging_count = 0
var enemyInfectionDone = true
var playerInfectionDone = true
var playerInfected = false
var enemyInfected = false
var playerOvertime = 0
var enemyOvertime = 0
var enemyDodging = false
var attackFails = false

@onready var HBox = get_node("Hand")
@onready var PlayerHealthBar = get_node("../../PlayerHealthBar")
@onready var EnemyHealthBar = get_node("../../EnemyHealthBar")
@onready var EnemyAnimator = get_node("../../Enemy")
@onready var PlayerAnimator = get_node("../../Player")
@onready var DialogContainer = get_node("../DialogContainer")

var card_preload = preload("res://Scenes/card_instance.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	deck = Global.deck.duplicate()
	draw()
	draw()
	enemy_id=Global.enemy_id
	EnemyAnimator.enemy_id=enemy_id
	EnemyAnimator.load_frames()
	enemy_health=enemies[enemy_id][1]
	enemy_max=enemy_health
	pass # Replace with function body.

func checkWhoseDead():
	if player_health <= 0:
		loseFlag=true
		DialogContainer.reset("You black out")
		return true
	elif enemy_health <= 0:
		winFlag=true
		DialogContainer.reset("You have slain the %s" % enemies[enemy_id][0])
		return true
	else:
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if((Input.is_action_just_pressed("interact") or Input.is_action_just_released("click")) and continuable):
		go_next=true
		continuable=false
	if(go_next):
		go_next=false
		if winFlag or runFlag:
			Global.reset=false
			$"..".setUp()
		elif loseFlag:
			Global.reset=true
			$"..".setUp()
		elif recoilFlag:
			DialogContainer.reset("Your helmet reverberates around your head")
			damage_player(50,false)
			recoilFlag=false
		elif checkWhoseDead():
			pass
		elif(i<len(queue)):
			if enemyDodging and randi_range(0,3)!=0:
				attackFails=true
			edamaged = false
			DialogContainer.reset(card_funcs[queue[i]].call())
			deck.append(queue[i])
			i+=1
			attackFails=false
		elif(queue!=[]):
			queue = []
			if(enemy_health<=0):
				winFlag=true
				DialogContainer.reset("You have slain the %s" % enemies[enemy_id][0])
				return true
			go_next = true
		elif(!enemyAttacked):
			enemyAttacked=true
			pdamaged= false
			# Call a random function from the enemies attack pattern
			DialogContainer.reset(enemies[enemy_id][3][randi_range(0,len(enemies[enemy_id][3])-1)].call())
		else:
			if !enemyInfectionDone:
				enemyInfectionDone=true
				damage_enemy(enemyOvertime,false)
				DialogContainer.reset("The %s takes poison damage" % enemies[enemy_id][0])
			elif !playerInfectionDone:
				playerInfectionDone=true
				damage_player(playerOvertime,false)
				DialogContainer.reset("You hurt from your wounds")
			else:
				draw()
				is_blocking=false
				$Button.disabled=false
				print("Enemy Health: " + str(enemy_health))
				print("Player Health: " + str(player_health))
				$Button.text= 'Skip Turn and draw an extra card'
				DialogContainer.reset(null)

			


func damage_enemy(amount,animated):
	if amount<=0:
		enemy_health=min(enemy_max,enemy_health-amount)
		EnemyHealthBar.TweenTo(enemy_health,enemy_max)
	elif(animated):
		if(enemy_blocking):
			amount/=4
		enemy_health-=amount
		PlayerAnimator.play("attack")
		edamaged=true
		enemyDodging=false
		EnemyAnimator.modulate.a = 1
	else:
		enemy_health-=amount
		EnemyAnimator.idle_current=EnemyAnimator.get_animation()
		EnemyAnimator.play("hurt")
		EnemyHealthBar.TweenTo(enemy_health,enemy_max)
		
# All player card functions
func slash():
	if !attackFails:
		damage_enemy(55,true)
		return "You slash at the %s" % enemies[enemy_id][0] 
	else:
		return "You swing, but miss"
func heal():
	# Make sure player doesnt overheal
	damage_player(-min(35,player_max-player_health),false)
	return "You heal some damage off" 
func block():
	is_blocking=true
	return "You raise your shield"
func poison():
	if !attackFails:
		EnemyHealthBar.Health_Rect.modulate = Color8(142,52,154)
		enemyInfected=true
		enemyInfectionDone=false
		enemyOvertime+=20
		return "You poison the %s" % enemies[enemy_id][0] 
	else:
		return "You try to poison the %s, but you miss" % enemies[enemy_id]
func water():
	PlayerHealthBar.Health_Rect.modulate = Color8(249,41,0)
	playerInfected=false
	playerInfectionDone=true
	playerOvertime=0
	return "You cleanse yourself"
func run():
	if enemies[enemy_id][4]:
		runFlag = true
		Global.running=true
		return "You run away"
	else:
		return "You can't run away from this battle" 
func recoil():
	if !attackFails:
		damage_enemy(90,true)
		recoilFlag=true
		return "You charge headfirst at the enemy"
	else:
		recoilFlag=true
		return "You charge headfirst straight into a tree"

func damage_player(amount,animated):
	if(amount<0):
		player_health-=amount
		player_health=min(player_health,player_max)
		PlayerHealthBar.TweenTo(player_health,player_max)
	elif(animated):
		if(is_blocking):
			amount/=4
		player_health-=amount
		EnemyAnimator.play("attack")
		pdamaged=true
	else:
		player_health-=amount
		PlayerAnimator.play("hurt")
		PlayerHealthBar.TweenTo(player_health,player_max)


# All enemy attack functions
func basic_attack():
	damage_player(50,true)
	return "The %s attacks" % enemies[enemy_id][0] 
func slimeai():
	if enemy_health > 60 or randf_range(0,2)>0.6:
		damage_player(55,true)
		return "The Water slime attacks!"
	else:
		damage_enemy(-50,false)
		return "The Water slime soaks up water to heal itself"
func batai():
	if !playerInfected and randi_range(0,1)!=0:
		PlayerHealthBar.Health_Rect.modulate = Color8(124,173,19)
		damage_player(20,true)
		playerInfected=true
		playerInfectionDone=false
		playerOvertime+=30
		return "The Rock bat sinks it's fangs into your neck"
	else:
		damage_player(45,true)
		return "The Rock bat attacks"
func golemAi():
	enemy_blocking=false
	if enemy_charging:
		enemy_charging_count+=randi_range(1,2)
		if enemy_charging_count>=2:
			EnemyAnimator.play("idle_fast")
			enemy_charging_count=0
			enemy_charging=false
			damage_player(150,true)
			return "The Golem releases a devastating attack"
		else:
			return "The Golem starts spinning faster"
	elif randi_range(0,2)==1:
		enemy_blocking=true
		EnemyAnimator.play("idle_closed")
		return "The Golem closes off"
	elif randi_range(0,2)==1:
		enemy_charging=true
		EnemyAnimator.play("idle_fast")
		return "The Golem starts spinning faster"
	damage_player(60,true)
	return "The Golem attacks"
func catAi():
	if randi_range(0,1)==1 and !enemyDodging:
		enemyDodging = true
		damage_player(0,true)
		EnemyAnimator.modulate.a = 0.0125
		return "The Cat leaps into the trees"
	else:
		damage_player(35,true)
		return "The Cat attacks"
		
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
		$Button.text ='Play cards'

func dequeue_card(card):
	queue.pop_at(queue.find(card))
	hand.append(card)
	if len(queue)==0:
		$Button.text ='Skip Turn and draw an extra card'


func _on_button_confirm_play():
	enemyAttacked=false
	i=0
	if enemyInfected:
		enemyInfectionDone=false
	if playerInfected:
		playerInfectionDone=false
	go_next=true
	if len(queue)==0:
		draw()


func _on_enemy_animation_finished():
	if pdamaged:
		PlayerAnimator.play("hurt")
		PlayerHealthBar.TweenTo(player_health,player_max)
		pdamaged=false

func _on_player_animation_finished():
	if edamaged:
		EnemyAnimator.idle_current=EnemyAnimator.get_animation()
		EnemyAnimator.play("hurt")
		EnemyHealthBar.TweenTo(enemy_health,enemy_max)
		edamaged=false

func _on_dialog_container_dialog_finished():
	continuable=true
	pass # Replace with function body.
