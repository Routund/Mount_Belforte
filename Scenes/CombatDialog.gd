extends CenterContainer
var text = "You block!"
@onready var label = get_node("Label")
@onready var dialogBackground = get_node("NinePatchRect")
var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if i<len(text):
		label.text+=text[i]
		i+=1
		dialogBackground.custom_minimum_size.x=label.size.x+24
	pass
