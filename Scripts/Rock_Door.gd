extends RigidBody2D

var button = 0
var open = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if open == button:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
