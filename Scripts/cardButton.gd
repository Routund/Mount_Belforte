extends TextureButton

var is_button_pressed=false
signal chosen
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_button_pressed and not is_pressed():
		chosen.emit()
		is_button_pressed=false
	elif is_pressed() and not is_button_pressed:
		is_button_pressed=true
	pass
