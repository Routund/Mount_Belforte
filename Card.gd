extends TextureButton

@export var card_id=0
var queue_pos=0
var queued = false


var battle_manager

@onready var text = get_node("Label")

var is_button_pressed = false
func _ready():
	text.text=str(card_id)
	battle_manager=get_parent().get_parent()
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_button_pressed and not is_pressed():
		is_button_pressed = false
		var new_parent=self
		if queued:
			new_parent = battle_manager.get_node("Hand")
			battle_manager.dequeue_card(card_id)
		else:
			new_parent = battle_manager.get_node("Queue")
			battle_manager.queue_card(card_id)
		queued=!queued
		get_parent().remove_child(self)
		new_parent.add_child(self)
		
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
