extends TextureButton

var card_id=0
var queue_pos=0
var queued = false

signal queue_card(card:int)
signal dequeue_card(pos:int)

var is_button_pressed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_button_pressed and not is_pressed():
		is_button_pressed = false
		if queued:
			dequeue_card.emit(queue_pos)
		else:
			queue_card.emit(card_id)
		
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
