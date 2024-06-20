extends CanvasLayer

var deck = 4

func _ready():
	hide()
	$Deck/Poison.hide()
	$Deck/Water.hide()

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
		$Deck/Block.hide()
		deck -= 1
	elif deck <= 8:
		Global.blockd = true
		$Deck/Block.show()
		deck += 1

func _on_attack_pressed():
	if Global.attackd == true:
		Global.attackd = false
		$Deck/Attack.hide()
		deck -= 1
	elif deck <= 8:
		Global.attackd = true
		$Deck/Attack.show()
		deck += 1

func _on_heal_pressed():
	if Global.heald == true:
		Global.heald = false
		$Deck/Heal.hide()
		deck -= 1
	elif deck <= 8:
		Global.heald = true
		$Deck/Heal.show()
		deck += 1

func _on_run_pressed():
	if Global.rund == true:
		Global.rund = false
		$Deck/Run.hide()
		deck -= 1
	elif deck <= 8:
		$Deck/Run.show()
		Global.rund = true
		deck += 1

func _on_water_pressed():
	if Global.water == true and Global.waterd == false and deck <= 8:
		Global.waterd = true
		$Deck/Water.show()
		deck += 1
	elif Global.water == true and Global.waterd == true:
		Global.waterd = false
		$Deck/Water.hide()
		deck -= 1

func _on_poison_pressed():
	if Global.poison == true and Global.poisond == false and deck <= 8:
		Global.poisond = true
		$Deck/Poison.show()
		deck += 1
	elif Global.poison == true and Global.poisond == true:
		Global.poisond = false
		$Deck/Poison.hide()
		deck -= 1


func _on_go_back_pressed():
	Global.inventory_open = false
	hide()
	$"../Resume".show()
	$"../Settings".show()
	$"../Inventor".show()
	$"../Exit".show()
