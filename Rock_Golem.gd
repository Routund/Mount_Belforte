extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("rock")



func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
