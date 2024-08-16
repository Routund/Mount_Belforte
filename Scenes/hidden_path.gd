extends Area2D

func _ready():
	hide()

func _on_body_entered(body):
	if body.name == "Player":
		show()


func _on_body_exited(body):
	if body.name == "Player":
		hide()
