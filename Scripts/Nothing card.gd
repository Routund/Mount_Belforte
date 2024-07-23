extends Area2D


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body):
	if body.name == "Player":
		if self.name == "card":
			Global.inventory.append(3)
		if self.name == "card2":
			pass
		queue_free()
		
