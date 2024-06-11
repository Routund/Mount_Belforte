extends CanvasLayer

var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("inventory") and paused == false:
		get_tree().paused = true
		paused = true
		show()
	elif Input.is_action_just_pressed("inventory") and paused == true:
		get_tree().paused = false
		paused = false
		hide()


func _on_button_pressed():
	get_tree().paused = false
	paused = false
	hide()


func _on_inventory_pressed():
	$Inventory.show()
	$Resume.hide()
	$Settings.hide()
	$Inventor.hide()
	$Exit.hide()
