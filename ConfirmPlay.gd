extends Button

signal confirmPlay

var is_button_pressed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_button_pressed and not is_pressed():
		is_button_pressed = false
		confirmPlay.emit()
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
	pass

