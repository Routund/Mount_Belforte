extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func animate():
	var tween = create_tween()
	for sprite in get_children():
		sprite.animate_self()
	pass

func _on_button_confirm_play():
	var tween = create_tween()
	for sprite in get_children():
		sprite.animate_self()
	pass
