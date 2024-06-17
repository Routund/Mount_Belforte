extends TextureButton

@export var card_id=0
@onready var text = get_node("Label")
var fake = true
# Called when the node enters the scene tree for the first time.
func _ready():
	text.text=str(card_id)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_free()
	pass
