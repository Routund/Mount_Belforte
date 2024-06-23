extends NinePatchRect

var health = 0
@onready var Health = get_node("Health")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func TweenTo(amount):
	var tween = create_tween()
	health=amount
	tween.tween_property(Health, "size.x", max(11,(360*amount)), 0.5)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	if(health==0):
		health.visible=false
