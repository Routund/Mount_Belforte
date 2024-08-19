extends Area2D
var dialogue = ["text"]
var id = 0
var done = false

@onready var DialogContainer = $"dialogue Container"
func _ready():
	
	DialogContainer.hide()
	id = int(str(self.name))


func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player" and done == false:
		DialogContainer.show()
		DialogContainer.reset(dialogue[id])
		done = true
