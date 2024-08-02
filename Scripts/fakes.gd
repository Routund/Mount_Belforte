extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func delete():
	for i in get_children():
		i.visible = false
		i.queue_free()

func change_spacing():
	var all_children = len(get_children())
	add_theme_constant_override("separation",-((all_children)*7))
