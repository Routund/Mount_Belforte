extends CharacterBody2D
# Declare member variables here. Examples:
# var a = 2
var death = false
var speed = 600
@onready var player = get_parent().get_parent().get_node("Player")

var movement_speed: float = 400.0
var _movement_target_position = Vector2.ZERO

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	$card.hide()
	$AnimationPlayer.play("Walk")
	Global.slime += 1
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
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
		if death == false:
			var rng = RandomNumberGenerator.new()
			var get_water = rng.randi_range(1,3)
			if 5 not in Global.inventory and get_water == 4: #make it three when water bottle works 
				$card.show()
				$Sprite2D.hide()
				death = true
			else:
				queue_free()
		elif death == true:
			Global.slime += 1
			Global.inventory.append(5)
			queue_free()
		
