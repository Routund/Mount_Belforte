extends Area2D
var card_id=3

# Called when the node enters the scene tree for the first time.
func _ready():
	if(card_id in Global.inventory):
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body):
	if body.name == "Player":
		Global.inventory.append(card_id)
		queue_free()
		
