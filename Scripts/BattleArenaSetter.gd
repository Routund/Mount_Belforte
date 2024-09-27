extends TextureRect

var arenas = [
	"res://Sprites/CaveCombat.png",
	"res://Sprites/Forest_Combat.png",
	"res://Sprites/Castle_Combat.png",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = load(arenas[Global.arena])
	if Global.arena==1:
		if Global.enemy_id!=5:
			scale.x=1.5
			scale.y=1.5
			position = Vector2(-321,-233)
		else:
			var player = $"../Player"
			player.scale.x=2.64
			player.scale.y=2.64
			player.position.y=500
	pass # Replace with function body.

