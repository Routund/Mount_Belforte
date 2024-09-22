extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_confirm_play():
	for i in get_children():
		i.fake.queue_free()
		i.queue_free()

func animate():
	for sprite in get_children():
		sprite.animate_self()
	pass

func change_spacing():
	add_theme_constant_override("separation",-(len(get_children())*7))
	for child in get_children():
		child.z_index=1
