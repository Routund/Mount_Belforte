extends Area2D
var on = false
var count = 0
var bodyCount = 0
var player = false
var rock = false

func _ready():
	$"..".button += 1
	$AnimationPlayer.play('off')


func _on_area_entered(area):
	if area.name == "Rock" or area.name == "Player":
		if area.name == "Player":
			player = true
		if area.name == "Rock":
			rock = true
		if not on: 
			on = true
			count += 1
			if count <= 1:
					$"..".open += 1
			$AnimationPlayer.play('on')


func _on_area_exited(area):
	if area.name == "Rock" or area.name == "Player":
		if on:
			if area.name == "Player":
				player = false
			if area.name == "Rock":
				rock = false
			if not rock and not player:
				count -= 1
				await get_tree().create_timer(2).timeout
				if count <= 1:
					on = false
					$"..".open -= 1
					$AnimationPlayer.play('off')
				
