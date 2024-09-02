extends Area2D
var no = false
var count = 0

func _ready():
	$"..".button += 1
	$AnimationPlayer.play('off')


func _process(delta):
	print($"..".open)


func _on_body_entered(body):
	if body.name == "Rock_bat" and body.rock == true or body.name == "Player":
		if not no:
			no = true
			count += 1
			if count <= 1:
					$"..".open += 1
			$AnimationPlayer.play('on')


func _on_body_exited(body):
	if body.name == "Rock_bat" and body.rock == true or body.name == "Player":
		if no:
			count -= 1
			await get_tree().create_timer(2).timeout
			if count <= 1:
				no = false
				$"..".open -= 1
				$AnimationPlayer.play('off')
