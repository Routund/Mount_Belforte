extends Area2D
var pressed = false
var leave = true
var count = 0
var bodyCount = 0

func _ready():
	$"..".button += 1
	$AnimationPlayer.play('off')

func _process(delta):
	if pressed == true:
		$AnimationPlayer.play('on')
	elif pressed == false:
		$AnimationPlayer.play('off')
	
	
func _on_body_entered(body):
	leave = false
	bodyCount+=1
	print(bodyCount)
	$"..".open += 1
	pressed = true

func _on_body_exited(body):
	bodyCount-=1
	print(bodyCount)
	if bodyCount==0:
		leave = true
		count+=1
		await get_tree().create_timer(2).timeout
		count-=1
		if count==0 and leave:
			$"..".open -= 1
			pressed = false
			leave=false
			
