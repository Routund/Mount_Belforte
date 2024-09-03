extends TextureRect

var arenas = [
	"res://Sprites/CaveCombat.png",
	"res://Sprites/Forest_Combat.png",
	"res://Sprites/Castle_Combat.png",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = load(arenas[Global.arena])
	pass # Replace with function body.

