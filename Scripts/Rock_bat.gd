extends CharacterBody2D
# Declare member variables here. Examples:
# var a = 2
var r = 500
var direction = Vector2.ZERO
var seen_player = false
var rock = false
var speed = 300
var rock_speed = 700
var roaming_speed = 250

@onready var player = get_parent().get_parent().get_node("Player")

var movement_speed: float = 400.0
var _movement_target_position = Vector2.ZERO

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	Global.battleStarting.connect(give_coords)
	if !Global.reset:
		print(get_parent().name)
		position= Global.state_dictionary["bat_pos %s" % get_parent().name]
		if (Global.state_dictionary["rock_state %s" % get_parent().name]):
			rock = true
			$Sprite2D.hide()
			return
	$rock.hide()
	$AnimationPlayer.play("walk")
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	if rock == false and seen_player == true:
		await get_tree().physics_frame
		set_movement_target(_movement_target_position)
func set_movement_target(_movement_target: Vector2):
	if rock == false:
		navigation_agent.target_position = player.global_position
	
func _physics_process(_delta):
	var current_agent_position: Vector2 = global_position
	if rock == false and seen_player == true:
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
	if rock == false and seen_player == true:
		velocity = new_velocity * speed
	elif seen_player == false:
		velocity = new_velocity * roaming_speed
	if rock == true:
		direction = Vector2.ZERO
		if $down.is_colliding() and $down.get_collider().name == "Player":
			direction += Vector2(0,-1)
		elif $up.is_colliding() and $up.get_collider().name == "Player":
			direction += Vector2(0,1)
		elif $left.is_colliding() and $left.get_collider().name == "Player":
			direction += Vector2(1,0)
		elif $right.is_colliding() and $right.get_collider().name == "Player":
			direction += Vector2(-1,0)
		elif $bottoml.is_colliding() and $bottoml.get_collider().name == "Player":
			direction += Vector2(1,-1)
		elif $bottomr.is_colliding() and $bottomr.get_collider().name == "Player":
			direction += Vector2(-1,-1)
		elif $topl.is_colliding() and $topl.get_collider().name == "Player":
			direction += Vector2(1,1)
		elif $topr.is_colliding() and $topr.get_collider().name == "Player":
			direction += Vector2(-1,1)
		if direction!= Vector2.ZERO:
			$"../Label".visible=true
			$"../Label".global_position.x=global_position.x-40
			$"../Label".global_position.y=global_position.y-97
		else:
			$"../Label".visible=false
		if Input.is_action_just_pressed("interact"):
			if rock_speed == 700:
				rock_speed = -700
				$Rock_collision.disabled = true
			else:
				rock_speed = 700
				$Rock_collision.disabled = false
		velocity = direction * rock_speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player" and !rock:
		rock = true
		Global.battle(1)

func give_coords():
	Global.state_dictionary["bat_pos %s" % get_parent().name]=position
	Global.state_dictionary["rock_state %s" % get_parent().name]=rock


func _on_vision_body_entered(body):
	if body.name == "Player":
		seen_player = true
