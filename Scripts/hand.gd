extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func animate():
	for sprite in get_children():
		sprite.animate_self()
	pass

func change_spacing():
	add_theme_constant_override("separation",-(len(get_children())*7))
	var i=0
	for child in get_children():
		child.z_index=2*i
		i+=1
	

