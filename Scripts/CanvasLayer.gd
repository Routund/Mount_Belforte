extends CanvasLayer

var deck = 4

func _ready():
	hide()

func _process(_delta):
	if Global.poison == false:
		$ScrollContainer/VBoxContainer/Poison.hide()
	else: 
		$ScrollContainer/VBoxContainer/Poison.show()
	
	if Global.water == false:
		$ScrollContainer/VBoxContainer/Water.hide()
	else: 
		$ScrollContainer/VBoxContainer/Water.show()

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

func _on_water_pressed():
	if Global.water == true and Global.waterd == false and deck <= 8:
		Global.nothingd = true
		deck += 1
	elif Global.water == true and Global.waterd == true:
		Global.waterd = false
		deck -= 1

func _on_poison_pressed():
	if Global.poison == true and Global.poisond == false and deck <= 8:
		Global.poisond = true
		deck += 1
	elif Global.poison == true and Global.poisond == true:
		Global.poisond = false
		deck -= 1


func _on_go_back_pressed():
	Global.inventory_open = false
	hide()
	$"../Resume".show()
	$"../Settings".show()
	$"../Inventor".show()
	$"../Exit".show()
