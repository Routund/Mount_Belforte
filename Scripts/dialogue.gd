extends Area2D
var dialogue = ["Welcome traveler to Mount Belforte. *Gargling noises*", "I know you like treasure, and I heard there was some at the 
					end of this cave. Go get them buster.", "You picked up Poison, tab to open your inventory", "You picked up Headbutt"]
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
	if done and Input.is_action_just_released("click"):
		id += 1
		funny += 1
		done=false
		if funny >= fin:
			DialogContainer.dialogFinished.disconnect(setDone)
			DialogContainer.visible=false
			get_tree().paused = false
			queue_free()
		else:
			DialogContainer.reset(dialogue[id])


func _on_body_entered(body):
	if body.name == "Player" and !done:
		player.tree.get("parameters/playback").travel("Idle")
		DialogContainer.show()
		DialogContainer.reset(dialogue[id])
		get_tree().paused = true
		DialogContainer.dialogFinished.connect(setDone)

func setDone():
	done=true
