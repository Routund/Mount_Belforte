extends CharacterBody2D
# Declare member variables here. Examples:
# var a = 2
var r = 300
var direction = Vector2.ZERO
var roaming_speed = 200
var seen_player = false
var death = false
var speed = 300
@onready var player = get_parent().get_parent().get_node("Player")
var card_preload = preload("res://Scenes/tester_card.tscn")

var movement_speed: float = 400.0
var _movement_target_position = Vector2.ZERO

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	Global.battleStarting.connect(give_coords)
	Global.slime += 1
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	navigation_agent.target_position = get_parent().global_position
	randomize()

func _physics_process(_delta):
	var current_agent_position: Vector2 = global_position
	if death == false and seen_player == true:
		navigation_agent.target_position = player.global_position
		if not navigation_agent.is_target_reachable():
			seen_player = false
		if navigation_agent.is_navigation_finished():
			return
	elif seen_player == false:
		if navigation_agent.is_navigation_finished():
			navigation_agent.target_position =global_position + Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()*randf_range(r/2,r)
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	if death == false and seen_player == true:
		velocity = new_velocity * speed
	elif seen_player == false:
		velocity = new_velocity * roaming_speed
	if new_velocity.x > new_velocity.y:
		if velocity.x > 0:
			$AnimationPlayer.play("Walk_right")
		else:
			$AnimationPlayer.play("Walk_left")
	else:
		if velocity.y < 0:
			$AnimationPlayer.play("Walk_up")
		else:
			$AnimationPlayer.play("Walk")
	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.battle(0)
		
func give_coords():
	Global.state_dictionary["slime_pos"]=position

func _on_vision_body_entered(body):
	if body.name == "Player":
		seen_player = true

