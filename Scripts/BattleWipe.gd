extends CanvasLayer
@onready var wiper = get_node("TextureRect")
var goUp = true
var goDown = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	wiper.position.y=0
	Global.battleStarting.connect(setDown)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(goUp):
		wiper.position.y-=20
	elif goDown:
		wiper.position.y+=20
		if wiper.position.y>=20:
			if(!Global.changing):
				get_tree().change_scene_to_file("res://Scenes/Battle.tscn")
			else:
				get_tree().change_scene_to_file(Global.overworld_scene)
				Global.changing=false
	pass

func setDown():
	goDown=true
	goUp=false
	wiper.position.y=-831