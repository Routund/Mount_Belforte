extends CenterContainer
var text = ""
var speed = 2
@onready var label = get_node("Label")
@onready var dialogBackground = get_node("NinePatchRect")
var i = 0
signal dialogFinished
# Called when the node enters the scene tree for the first time.
func _ready():
	visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if i<len(text)*speed:
		if i%speed==0:
			label.text+=text[i/speed]
			dialogBackground.custom_minimum_size.x=label.size.x+250
			dialogBackground.custom_minimum_size.y=label.size.y+175
		i+=1
		if i==len(text)*speed:
			dialogFinished.emit()
			i+=1
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
