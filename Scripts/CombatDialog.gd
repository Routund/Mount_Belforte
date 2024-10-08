extends CenterContainer
var text = ""
var speed = 2
@onready var label = get_node("Label")
@onready var dialogBackground = get_node("NinePatchRect")
var i = 0
signal dialogFinished
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if i<len(text)*speed:
		if i%speed==0:
			label.text+=text[i/speed]
			dialogBackground.custom_minimum_size.x=label.size.x+24
		i+=1
		if i==len(text)*speed:
			dialogFinished.emit()
	pass

func reset(newText):
	if newText == null:
		visible=false
	else:
		text=newText
		i=0
		visible=true
	label.text=""
	dialogBackground.custom_minimum_size.x=12
