extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		modulate.a8 = 128


func _on_body_exited(body):
	if body.name == "Player":
		modulate.a8 = 255
