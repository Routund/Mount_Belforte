extends Area2D


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body):
	if body.name == "Player":
		Global.nothing = true
		queue_free()
