extends Area2D
var card_id = 0
var id = 0
var dialogue = ["You picked up Poison, tab to open pause menu", "You picked up Headbutt", "You picked up Water Bottle"]
@onready var DialogContainer = get_parent().get_node("Player").get_node("dialogue Container")
@onready var player = get_parent().get_node("Player")
var done = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if card_id==0:
		card_id = int(str(self.name.split(" ")[0]))
	if(card_id in Global.inventory):
		queue_free()
	if id == 0:
		id = int(self.name.split(" ")[1])

func _process(delta):
	if done:
		print("haha")
	if done and Input.is_action_just_released("click"):
		DialogContainer.visible=false
		get_tree().paused = false
		queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		player.tree.get("parameters/playback").travel("Idle")
		DialogContainer.show()
		DialogContainer.reset(dialogue[id])
		get_tree().paused = true
		DialogContainer.dialogFinished.connect(setDone)
		Global.inventory.append(card_id)
		hide()

func setDone():
	done=true
