extends CharacterBody2D
# Declare member variables here. Examples:
# var a = 2
var seen_player = false
var rock = false
<<<<<<< Updated upstream
var speed = 600
var rock_speed = 700
=======
var speed = 400
var rock_speed = 400
var direction = Vector2.ZERO
>>>>>>> Stashed changes
@onready var player = get_parent().get_parent().get_node("Player")

var movement_speed: float = 400.0
var _movement_target_position = Vector2.ZERO

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	$rock.hide()
	$AnimationPlayer.play("walk")
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	call_deferred("actor_setup")

func actor_setup():
	if rock == false:
		await get_tree().physics_frame
		set_movement_target(_movement_target_position)
func set_movement_target(_movement_target: Vector2):
	if rock == false:
		navigation_agent.target_position = player.global_position
	
func _physics_process(_delta):
	if rock == false and seen_player == true:
		navigation_agent.target_position = player.global_position
		if navigation_agent.is_navigation_finished():
			return
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		var new_velocity: Vector2 = next_path_position - current_agent_position
		new_velocity = new_velocity.normalized()
		velocity = new_velocity * speed
	elif rock == true:
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
		if Input.is_action_just_pressed("interact"):
			if rock_speed == 700:
				rock_speed = -700
				$Rock_collision.disabled = true
			else:
				rock_speed = 900
				$Rock_collision.disabled = false
		velocity = direction * rock_speed
	elif seen_player == false:
		if $down.is_colliding():
			direction = Vector2(0,-1)
		elif $up.is_colliding():
			direction = Vector2(0,1)
		elif $left.is_colliding():
			direction = Vector2(1,0)
		elif $right.is_colliding():
			direction = Vector2(-1,0)
		if direction == Vector2(0,0):
			direction = Vector2(-1,0)
		velocity = direction * speed
			
	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.battle(0)
		rock = true
<<<<<<< Updated upstream
		$rock.show()
		$Sprite2D.hide()
=======
		Global.battle(1)

func give_coords():
	Global.state_dictionary["bat_pos"]=position
	Global.state_dictionary["rock_state"]=rock


func _on_vision_body_entered(body):
	if body.name == "Player":
		seen_player = true
>>>>>>> Stashed changes
