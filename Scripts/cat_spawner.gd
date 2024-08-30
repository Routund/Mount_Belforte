extends Node2D

var cat = preload("res://Scenes/cat.tscn")
@onready var player = get_parent().get_node("Player")
var count = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	pass

func _process(delta):
	if player.velocity != Vector2(0,0):
		count+=delta*10
	if count > 10:
		count=0
		var spawn_cat = cat.instantiate()
		spawn_cat.position = $Spawn_point.position
		add_child(spawn_cat)
