extends CanvasLayer

var paused = false

func _ready():
	hide()

func _process(_delta):
	if Input.is_action_just_pressed("inventory") and paused == false:
		get_tree().paused = true
		paused = true
		show()
	elif Input.is_action_just_pressed("inventory") and paused == true:
		get_tree().paused = false
		paused = false
		hide()
	
	if Global.nothing == false:
		$ScrollContainer/VBoxContainer/Nothing.hide()
	else: 
		$ScrollContainer/VBoxContainer/Nothing.show()

func _on_Nothing_pressed():
	if Global.nothing == true and Global.nothingd == true:
		Global.nothingd = false
	elif Global.nothing == true:
		Global.nothingd = true

func _on_block_pressed():
	if Global.blockd == true:
		Global.blockd = false
	else:
		Global.blockd = true

func _on_attack_pressed():
	if Global.attackd == true:
		Global.attackd = false
	else:
		Global.attackd = true

func _on_heal_pressed():
	if Global.heald == true:
		Global.heald = false
	else:
		Global.heald = true

func _on_run_pressed():
	if Global.rund == true:
		Global.rund = false
	else:
		Global.rund = true
