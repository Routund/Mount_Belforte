extends AnimatedSprite2D

const frame_paths = [
	["bleh",3]
]
var enemy_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("animation_finished",set_to_idle)
	play("idle")
	pass # Replace with function body.

func set_to_idle():
	play("idle")
