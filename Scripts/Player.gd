extends CharacterBody2D

var speed = 700
@onready var tree = get_node("AnimationTree")

func _ready():
	$AnimationPlayer.play("idle_down")
	Global.battleStarting.connect(give_coords)
	if !Global.reset:
		position= Global.state_dictionary["player_pos"]
	else:
		Global.state_dictionary.clear()

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = direction * speed
	
	if direction == Vector2.ZERO:
		tree.get("parameters/playback").travel("Idle")
	else:
		tree.get("parameters/playback").travel("Walk")
		tree.set("parameters/Idle/BlendSpace2D/blend_position", direction)
		tree.set("parameters/Walk/BlendSpace2D/blend_position", direction)
	
	move_and_slide()

func give_coords():
	Global.state_dictionary["player_pos"]=position
