extends AnimatedSprite2D

const frame_paths = [
	["res://Sprites/Combat_enemies/Slime.tres",3,-40,-32],
	["res://Sprites/Combat_enemies/rockbat.tres",1.25,-80,-100]
]
var enemy_id = 0

# Called when the node enters the scene tree for the first time.
func load_frames():
	sprite_frames = load(frame_paths[enemy_id][0])
	scale.x = frame_paths[enemy_id][1]
	scale.y = frame_paths[enemy_id][1]
	offset.x=frame_paths[enemy_id][2]
	offset.y=frame_paths[enemy_id][3]
	connect("animation_finished",set_to_idle)
	play("idle")
	pass # Replace with function body.

func set_to_idle():
	play("idle")
	
