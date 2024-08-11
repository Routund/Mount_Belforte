extends CharacterBody2D
# Declare member variables here. Examples:
# var a = 2
<<<<<<< Updated upstream
=======
var direction = Vector2.ZERO
var roaming_speed = 250
var seen_player = false
>>>>>>> Stashed changes
var seen_player = false
var death = false
var speed = 300
var water_card = false
@onready var player = get_parent().get_parent().get_node("Player")
@onready var card=get_node("card")
@onready var Sprite= get_node("Sprite2D")
var card_preload = preload("res://Scenes/tester_card.tscn")

var movement_speed: float = 400.0
var _movement_target_position = Vector2.ZERO

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	if water_card:
		var instance = card_preload.instantiate()
		instance.card_id=5
		get_parent().add_child(instance)
		instance.global_position = global_position
		queue_free()
	Global.battleStarting.connect(give_coords)
	$AnimationPlayer.play("Walk")
	Global.slime += 1
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	if seen_player == true:
		await get_tree().physics_frame
		set_movement_target(_movement_target_position)

func set_movement_target(_movement_target: Vector2):
	navigation_agent.target_position = player.global_position
	
func _physics_process(_delta):
	if death == false and seen_player == true:
		navigation_agent.target_position = player.global_position
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	velocity = new_velocity * speed
	if seen_player == false:
		pass #make slime roam around water
		velocity = direction * roaming_speed
	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		var rng = RandomNumberGenerator.new()
		var get_water = rng.randi_range(1,3)
		if 5 not in Global.inventory and get_water == 3: #make it threea when water bottle works 
			Global.state_dictionary["water"]=water_card
			Global.slime=3
		else:
			Global.slime = 1
		Global.battle(0)
		
func give_coords():
	Global.state_dictionary["slime_pos"]=position

func _on_vision_body_entered(body):
	if body.name == "Player":
		seen_player = true

