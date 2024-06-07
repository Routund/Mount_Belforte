extends TextureButton

@export var card_id=0
var queue_pos=0
var queued = false

signal queue_card(card:int)
signal dequeue_card(pos:int)

var is_button_pressed = false
func _ready():
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_button_pressed and not is_pressed():
		is_button_pressed = false
		var new_parent=self
		if queued:
			new_parent = get_parent().get_parent().get_node("Hand")
			dequeue_card.emit(queue_pos)
		else:
			queue_card.emit(card_id)
			new_parent = get_parent().get_parent().get_node("Queue")
		get_parent().remove_child(self)
		new_parent.add_child(self)
		
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
	print(card_id)
