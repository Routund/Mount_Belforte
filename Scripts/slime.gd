extends CharacterBody2D
# Declare member variables here. Examples:
# var a = 2
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
	if death == false:
		navigation_agent.target_position = player.global_position
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	velocity = new_velocity * speed
	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.slime -= 1
		if death == true:
			Global.slime = 1
			var rng = RandomNumberGenerator.new()
			var get_water = rng.randi_range(1,1)
			if 5 not in Global.inventory and get_water == 1: #make it threea when water bottle works 
				Global.state_dictionary["water"]=water_card
		Global.battle(0)
		
func give_coords():
	Global.state_dictionary["slime_pos"]=position

func _on_vision_body_entered(body):
	if body.name == "Player":
		seen_player = true

