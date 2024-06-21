extends CharacterBody2D
# Declare member variables here. Examples:
# var a = 2

var rock = false
var speed = 600
var rock_speed = 700
@onready var player = get_parent().get_node("Player")

var movement_speed: float = 400.0
var _movement_target_position = Vector2.ZERO

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	if rock == false:
		await get_tree().physics_frame
		set_movement_target(_movement_target_position)
func set_movement_target(_movement_target: Vector2):
	if rock == false:
		navigation_agent.target_position = player.global_position
	
func _physics_process(_delta):
	if rock == false:
		navigation_agent.target_position = player.global_position
		if navigation_agent.is_navigation_finished():
			return
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		var new_velocity: Vector2 = next_path_position - current_agent_position
		new_velocity = new_velocity.normalized()
		velocity = new_velocity * speed
	else: 
		var direction = Vector2.ZERO
		if $down.is_colliding():
			direction += Vector2(0,-1)
		elif $up.is_colliding():
			direction += Vector2(0,1)
		elif $left.is_colliding():
			direction += Vector2(1,0)
		elif $right.is_colliding():
			direction += Vector2(-1,0)
		elif $bottoml.is_colliding():
			direction += Vector2(1,-1)
		elif $bottomr.is_colliding():
			direction += Vector2(-1,-1)
		elif $topl.is_colliding():
			direction += Vector2(1,1)
		elif $topr.is_colliding():
			direction += Vector2(-1,1)
		velocity = direction * rock_speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		rock = true
