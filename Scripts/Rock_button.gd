extends Area2D



func _on_body_entered(body):
	if body.name == "Rock_bat" and body.rock == true:
		print("open")


func _on_body_exited(body):
	if body.name == "Rock_bat" and body.rock == true:
		print("closed")
