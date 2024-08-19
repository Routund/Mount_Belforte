extends CanvasLayer
@onready var wiper = get_node("Wiper")
var goUp = false
var goDown = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	wiper.position.y=0
	Global.battleStarting.connect(setUp)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(goUp):
		wiper.position.y-=20
		if wiper.position.y<=-20:
			get_tree().change_scene_to_file(Global.overworld_scene)
	elif goDown:
		wiper.position.y+=20
	pass

func setUp():
	goDown=false
	goUp=true
	wiper.position.y=831


