extends TextureButton

@export var card_id=0
var queue_pos=0
var queued = false
var previous_pos = Vector2(0,-7)
var battle_manager
var animate = false
var hand = self
var queue = self
var fakeH = self
var fakeQ = self
@onready var text = get_node("Label")
var fake_preload = preload("res://Scenes/fake_card.tscn")
var fake = self
var new_parent=self
var parentSelf=false

var is_button_pressed = false
func _ready():
	text.text=str(card_id)
	battle_manager=get_parent().get_parent()
	queue = battle_manager.get_node("Queue")
	hand = battle_manager.get_node("Hand")
	fakeQ = battle_manager.get_node("FakeQ")
	fakeH = battle_manager.get_node("FakeH")
	fake = fake_preload.instantiate()
	fakeH.add_child(fake)
	previous_pos=global_position-Vector2(0,-100)
	animate = true
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if animate:
		animate =false
		hand.animate()
		queue.animate()

	if is_button_pressed and not is_pressed():
		is_button_pressed = false
		var new_fake_parent= self
		if queued:
			new_parent = hand
			new_fake_parent = fakeH
			battle_manager.dequeue_card(card_id)
		else:
			new_parent = queue
			new_fake_parent = fakeQ
			battle_manager.queue_card(card_id)
		queued=!queued
		animate=true
		fake.get_parent().remove_child(fake)
		new_fake_parent.add_child(fake)
		parentSelf=true
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true

func animate_self():
	var newTransform = fake.global_position
	var tween = create_tween()
	tween.tween_property(self, "global_position", newTransform, 0.08)
	tween.connect("finished", on_tween_finished)
	disabled = true

func on_tween_finished():
	previous_pos=global_position
	disabled = false
	if parentSelf:
		reparent(new_parent)
	global_position=fake.global_position

