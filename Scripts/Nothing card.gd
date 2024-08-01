extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if("poison_picked" in Global.state_dictionary.keys()):
		if(Global.state_dictionary["poison_picked"]):
			queue_free()
		else:
			Global.state_dictionary["poison_picked"] = true

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body):
	if body.name == "Player":
		if self.name == "card":
			Global.inventory.append(3)
		if self.name == "card2":
			pass
		Global.state_dictionary["poison_picked"]=true
		queue_free()
		
