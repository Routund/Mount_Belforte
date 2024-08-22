extends Area2D
var pressed = false
var leave = true

func _ready():
	$"..".button += 1
	$AnimationPlayer.play('off')

func _process(delta):
	if pressed == true:
		$AnimationPlayer.play('on')
	elif pressed == false:
		$AnimationPlayer.play('off')
	
	
func _on_body_entered(body):
	if pressed == false and body.name == "Rock_bat" and body.rock == true or body.name == "Player" and pressed == false:
		$"..".open += 1
		print($"..".open)
		pressed = true
		leave = false

func _on_body_exited(body):
	if body.name == "Rock_bat" and leave == false and body.rock == true or body.name == "Player" and leave == false:
		leave = true
		await get_tree().create_timer(2).timeout
		$"..".open -= 1
		print($"..".open)
		pressed = false
