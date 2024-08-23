extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("rock")
	if "Golem" in Global.state_dictionary.keys():
		queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		Global.battle(2)
		Global.state_dictionary["Golem"]=true
