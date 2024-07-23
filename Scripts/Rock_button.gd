extends Area2D


func _ready():
	$"..".button += 1
func _on_body_entered(body):
	if body.name == "Rock_bat" and body.rock == true or body.name == "Player":
		$"..".open += 1

func _on_body_exited(body):
	if body.name == "Rock_bat" and body.rock == true or body.name == "Player":
		$"..".open -= 1
