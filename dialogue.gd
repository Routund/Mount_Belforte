extends Area2D
var dialogue = ["texdfsdfdgfsdgfdfsdsgdfsdft", "hi"]
var id = 0
var fin = 3
var funny = 0
var done = false

@onready var DialogContainer = get_parent().get_node("Player").get_node("dialogue Container")
@onready var player = get_parent().get_node("Player")
func _ready():
	DialogContainer.hide()
	id = int(self.name.split(" ")[0])
	fin = int(self.name.split(" ")[1])


func _process(delta):
	if Input.is_action_just_pressed("interact") or Input.is_action_just_released("click") and done == true:
		id += 1
		funny += 1
		if funny >= fin:
			hide()
			DialogContainer.visible=false
			get_tree().paused = false
		else:
			DialogContainer.reset(dialogue[id])


func _on_body_entered(body):
	if body.name == "Player" and done == false:
		player.tree.get("parameters/playback").travel("Idle")
		DialogContainer.show()
		DialogContainer.reset(dialogue[id])
		get_tree().paused = true
		done = true
