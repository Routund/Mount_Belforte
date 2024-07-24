extends AnimatedSprite2D

const frame_paths = [
	["res://Sprites/Combat_enemies/Slime.tres",3]
]
var enemy_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_frames = load(frame_paths[enemy_id][0])
	scale.x = frame_paths[enemy_id][1]
	scale.y = frame_paths[enemy_id][1]
	connect("animation_finished",set_to_idle)
	play("idle")
	pass # Replace with function body.

func set_to_idle():
	play("idle")
	
