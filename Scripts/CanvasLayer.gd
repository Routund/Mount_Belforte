extends CanvasLayer

var deck = 4

func _ready():
	hide()
	if 0 not in Global.deck:
		$Deck/Attack.hide()
	if 1 not in Global.deck:
		$Deck/Heal.hide()
	if 2 not in Global.deck:
		$Deck/Block.hide()
	if 3 not in Global.deck:
		$Deck/Poison.hide()
	if 4 not in Global.deck:
		$Deck/Run.hide()
	if 5 not in Global.deck:
		$Deck/Water.hide()

func _process(_delta):
	if 3 in Global.inventory:
		$ScrollContainer/VBoxContainer/Poison.show()
	else: 
		$ScrollContainer/VBoxContainer/Poison.hide()
	if 5 in Global.inventory:
		$ScrollContainer/VBoxContainer/Water.show()
	else:
		$ScrollContainer/VBoxContainer/Water.hide()
	
	

func _on_block_pressed():
	if 2 in Global.deck:
		Global.deck.pop_at(Global.deck.find(2))
		$Deck/Block.hide()
		deck -= 1
	elif deck <= 8:
		Global.deck.append(2)
		$Deck/Block.show()
		deck += 1

func _on_attack_pressed():
	if 0 in Global.deck:
		Global.deck.pop_at(Global.deck.find(0))
		$Deck/Attack.hide()
		deck -= 1
	elif deck <= 8:
		Global.deck.append(0)
		$Deck/Attack.show()
		deck += 1

func _on_heal_pressed():
	if 1 in Global.deck:
		Global.deck.pop_at(Global.deck.find(1))
		$Deck/Heal.hide()
		deck -= 1
	elif deck <= 8:
		Global.deck.append(1)
		$Deck/Heal.show()
		deck += 1

func _on_run_pressed():
	if 4 in Global.deck:
		Global.deck.pop_at(Global.deck.find(4))
		$Deck/Run.hide()
		deck -= 1
	elif deck <= 8:
		Global.deck.append(4)
		$Deck/Run.show()
		deck += 1

func _on_water_pressed():
	if 5 in Global.deck:
		Global.deck.pop_at(Global.deck.find(5))
		$Deck/Water.hide()
		deck -= 1
	elif deck <= 8 and 5 in Global.inventory:
		Global.deck.append(5)
		$Deck/Water.show()
		deck += 1

func _on_poison_pressed():
	if 3 in Global.deck:
		Global.deck.pop_at(Global.deck.find(3))
		$Deck/Poison.hide()
		deck -= 1
	elif deck <= 8 and 3 in Global.inventory:
		Global.deck.append(3)
		$Deck/Poison.show()
		deck += 1


func _on_go_back_pressed():
	Global.inventory_open = false
	hide()
	$"../Resume".show()
	$"../Settings".show()
	$"../Inventor".show()
	$"../Exit".show()
