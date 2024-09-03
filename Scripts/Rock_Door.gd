extends CharacterBody2D

var button = 0
var open = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if open < 0:
		open = 0
	if open >= button:
		$CollisionShape2D.disabled = true
		$Sprite2D.hide()
	else:
		$CollisionShape2D.disabled = false
		$Sprite2D.show()
