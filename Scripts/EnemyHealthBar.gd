extends NinePatchRect

var health = 0
@onready var Health_Rect = get_node("Health")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func TweenTo(enemy_health,enemy_max):
	var tween = create_tween()
	health=enemy_health
	print(float(enemy_health)/enemy_max*360)
	tween.tween_property(Health_Rect, "size", Vector2(max(11,float(enemy_health)/enemy_max*360),Health_Rect.size.y), 0.8)
	var tween_position = create_tween()
	tween_position.tween_property(Health_Rect, "position", Vector2(min(360-float(enemy_health)/enemy_max*360,360-11),0), 0.8)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	if(health<0):
		Health_Rect.visible=false
