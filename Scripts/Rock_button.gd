extends Area2D


func _ready():
	$"..".button += 1
	$AnimationPlayer.play('off')

func _on_body_entered(body):
	if body.name == "Rock_bat" and body.rock == true or body.name == "Player":
		$"..".open += 1
		$AnimationPlayer.play('on')

func _on_body_exited(body):
	if body.name == "Rock_bat" and body.rock == true or body.name == "Player":
		await get_tree().create_timer(2).timeout
		$"..".open -= 1
		$AnimationPlayer.play('off')
