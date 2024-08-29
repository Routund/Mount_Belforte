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

func _ready():
	Global.slime += 1
	randomize()

func _physics_process(_delta):
	if player.velocity != Vector2(0,0):
		velocity = Vector2(540,0)
	else:
		velocity = Vector2(0,0)
	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.battle(0)
		

func _on_vision_body_entered(body):
	if body.name == "Player":
		seen_player = true

