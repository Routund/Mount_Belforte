extends CanvasLayer

var paused = false
var deck = 4

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

func _on_block_pressed():
	if Global.blockd == true:
		Global.blockd = false
		deck -= 1
	elif deck <= 8:
		Global.blockd = true
		deck += 1

func _on_attack_pressed():
	if Global.attackd == true:
		Global.attackd = false
		deck -= 1
	elif deck <= 8:
		Global.attackd = true
		deck += 1

func _on_heal_pressed():
	if Global.heald == true:
		Global.heald = false
		deck -= 1
	elif deck <= 8:
		Global.heald = true
		deck += 1

func _on_run_pressed():
	if Global.rund == true:
		Global.rund = false
		deck -= 1
	elif deck <= 8:
		Global.rund = true
		deck += 1

func _on_nothing_pressed():
	if Global.nothing == true and Global.nothingd == false and deck <= 8:
		Global.nothingd = true
		deck += 1
	elif Global.nothing == true and Global.nothingd == true:
		Global.nothingd = false
		deck -= 1
