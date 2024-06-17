extends TextureButton

@export var card_id=0
var queue_pos=0
var queued = false
var previous_pos = Vector2(0,-7)
var battle_manager
var animate = false
var hand = self
var queue = self
@onready var text = get_node("Label")

var is_button_pressed = false
func _ready():
	text.text=str(card_id)
	battle_manager=get_parent().get_parent()
	previous_pos = global_position-Vector2(0,-500)
	queue = battle_manager.get_node("Queue")
	hand = battle_manager.get_node("Hand")
	animate=true
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if animate:
		animate =false
		hand.animate()
		queue.animate()

	if is_button_pressed and not is_pressed():
		is_button_pressed = false
		var new_parent=self

		if queued:
			new_parent = hand
			battle_manager.dequeue_card(card_id)
		else:
			new_parent = queue
			battle_manager.queue_card(card_id)
		queued=!queued
		animate=true
		get_parent().remove_child(self)
		new_parent.add_child(self)
		
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true

func animate_self():
	print(card_id)
	print(global_position)
	var newTransform = global_position
	var tween = create_tween()
	global_position=previous_pos
	tween.tween_property(self, "global_position", newTransform, 0.04)
	tween.connect("finished", on_tween_finished)
	disabled = true

func on_tween_finished():
	previous_pos=global_position
	print(card_id)
	print(previous_pos)
	disabled = false
	
	
