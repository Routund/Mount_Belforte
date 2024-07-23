extends NinePatchRect

var health = 0
@onready var Health_Rect = get_node("Health")
signal playerHealthBarFinished
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func TweenTo(player_health,player_max):
	var tween = create_tween()
	health=player_health
	tween.tween_property(Health_Rect, "scale", Vector2(max(0,float(player_health)/player_max),Health_Rect.scale.y), 0.8)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	if(health<0):
		Health_Rect.visible=false
	playerHealthBarFinished.emit()
